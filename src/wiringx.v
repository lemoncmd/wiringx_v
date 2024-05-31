module wiringx

#include <wiringx.h>

fn C.wiringXSetup(name &u8, voidptr) int
fn C.delayMicroseconds(ms u32)
fn C.wiringXGC() int
fn C.wiringXPlatform() &u8

// cleanup function for wiringx
fn cleanup() {
	C.wiringXGC()
}

// setup wiringx in the top of main function.
// `name` is the platform name.
pub fn setup(name string) {
	if C.wiringXSetup(name.str, unsafe { nil }) == -1 {
		exit(1)
	}
}

// get the platform name after setup.
pub fn platform() string {
	return unsafe { cstring_to_vstring(C.wiringXPlatform()) }
}

// wait for microseconds.
pub fn delay_us(us u32) {
	C.delayMicroseconds(us)
}
