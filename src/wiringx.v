module wiringx

import runtime

#include <wiringx.h>

fn C.wiringXSetup(name &u8, voidptr) int
fn C.wiringXGC() int

// init function for wiringx
fn init() {
	mem := runtime.total_memory()
	device := if mem < 100_000_000 {
		'milkv_duo'
	} else if mem < 300_000_000 {
		'milkv_duo256m'
	} else {
		'milkv_duos'
	}
	C.wiringXSetup(device.str, unsafe { nil })
}

// cleanup function for wiringx
fn cleanup() {
	C.wiringXGC()
}
