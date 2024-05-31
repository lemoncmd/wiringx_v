module wiringx

fn C.wiringXValidGPIO(pin int) int
fn C.pinMode(pin int, mode PinMode)

enum PinMode {
	input     = C.PINMODE_INPUT
	output    = C.PINMODE_OUTPUT
	interrupt = C.PINMODE_INTERRUPT
}

@[noinit]
struct GPIO {
	pin int
}

fn GPIO.new(pin int, mode PinMode) !GPIO {
	if C.wiringXValidGPIO(pin) != 0 {
		return error('Invalid GPIO ${pin}')
	}
	C.pinMode(pin, mode)
	return GPIO{pin}
}

interface GPIORead {
	read() int
}

pub fn GPIORead.new() !GPIORead {
	panic('unimplemented')
}

interface GPIOWrite {
	write(value bool)
}

pub fn GPIOWrite.new() !GPIOWrite {
	panic('unimplemented')
}

pub enum ISRMode {
	rising  = C.ISR_MODE_RISING
	falling = C.ISR_MODE_FALLING
	both    = C.ISR_MODE_BOTH
}

interface GPIOInterrupt {
	set_isr(mode ISRMode)
	wait_for_interrupt(timeout_ms int)
}

pub fn GPIOInterrupt.new() !GPIOInterrupt {
	panic('unimplemented')
}
