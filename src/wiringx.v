module wiringx

#include <wiringx.h>

fn C.wiringXSetup(name &u8, voidptr) int
fn C.delayMicroseconds(ms u32)
fn C.wiringXGC() int
fn C.wiringXPlatform() &u8

// init function for wiringx
fn init() {
	name := C.wiringXPlatform()
	if C.wiringXSetup(name, unsafe { nil }) == -1 {
		exit(1)
	}
}

// cleanup function for wiringx
fn cleanup() {
	C.wiringXGC()
}

pub fn platform() string {
	return unsafe { cstring_to_vstring(C.wiringXPlatform()) }
}

pub fn delay_ms(ms u32) {
	C.delayMicroseconds(ms)
}
