#!/usr/bin/env python3

# Copyright 2016, 2017 Andrew Conrad
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

"""Tool to initialize Thrustmaster racing wheels."""

import argparse
import time
import tmdrv_devices
import usb1
from importlib import import_module
from os import path
from subprocess import check_call, CalledProcessError

device_list = ['thrustmaster_t500rs', 'thrustmaster_tmx', 'thrustmaster_tx', 'thrustmaster_tsxw']
_context = usb1.USBContext()

def initialize(device_name='thrustmaster_tx'):
	try:
		device = import_module('tmdrv_devices.' + device_name)
	except ModuleNotFoundError:
		print('Device name "' + device_name + '" is invalid.')
		raise

	try:
		device
	except UnboundLocalError:
		print('Device name "' + device_name + '" is invalid.')
		raise

	# Send all control packets for initialization
	for m in device.control:
		try:
			_control_init(
				device.idVendor, device.idProduct[m['step'] - 1],
				m['request_type'],
				m['request'],
				m['value'],
				m['index'],
				m['data'],
			)
		except usb1.USBErrorNotFound:
			print('Error getting handle for device {:0=4x}:{:0=4x} ({} Step {}).'.format(device.idVendor, device.idProduct[m['step']-1], device.name, m['step']))
			raise
		except usb1.USBErrorNoDevice:
			# Caught when device switches modes
			pass
		except usb1.USBErrorPipe:
			# Possibly caught when device switches modes on older libusb
			pass
		except usb1.USBErrorIO:
			# Possibly caught when device switches modes on newer
			# libusb. This still has to be investigated, there might
			# be another issue going on here.
			pass

		# Wait for device to switch
		connected = False
		while not connected:
			handle = _context.openByVendorIDAndProductID(
				device.idVendor, device.idProduct[m['step']],
			)
			if handle is not None:
				connected = True

	# Load configuration to remove deadzones
	if device.jscal is not None:
		dev_path = '/dev/input/by-id/' + device.dev_by_id
		# Sometimes the device symlink is not ready in time, so we wait
		n = 9
		while not path.islink(dev_path):
			if n > 0:
				time.sleep(.5)
				n -= 1
			else:
				print('Device "{}" not found, skipping device calibration'.format(dev_path))
				raise FileNotFoundError
		_jscal(device.jscal, dev_path)

def _jscal(configuration, device_file):
	try:
		check_call(['jscal', '-s', configuration, device_file])
	except FileNotFoundError:
		print('jscal not found, skipping device calibration.')
	except CalledProcessError as err:
		print('jscal non-zero exit code {}, device may not be calibrated'.format(str(err)[-1]))

def _control_init(idVendor, idProduct, request_type, request, value, index, data):
	handle = _context.openByVendorIDAndProductID(
		idVendor, idProduct,
	)
	if handle is None:
		raise usb1.USBErrorNotFound('Device not found or wrong permissions')
	handle.setAutoDetachKernelDriver(True)
	handle.claimInterface(0)

	# Send control packet that will switch modes
	handle.controlWrite(
		request_type,
		request,
		value,
		index,
		data,
	)

if __name__ == '__main__':
	parser = argparse.ArgumentParser(description=__doc__)
	parser.add_argument('-d', '--device', default='thrustmaster_tx',
		help='Specify device to use')
	parser.add_argument('-D', '--supported-devices', action='store_true',
		help='List all supported devices')
	args = parser.parse_args()

	if args.supported_devices:
		for d in device_list:
			print(d)
	else:
		initialize(args.device)
