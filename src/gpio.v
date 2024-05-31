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

fn (g GPIO) read() int {
	panic('unimplemented')
}

fn (g GPIO) write(value DigitalValue) {
	panic('unimplemented')
}

fn (g GPIO) set_isr(mode ISRMode) {
	panic('unimplemented')
}

fn (g GPIO) wait_for_interrupt(timeout_ms int) {
	panic('unimplemented')
}

interface GPIORead {
	read() int
}

pub fn GPIORead.new(pin int) !GPIORead {
	return GPIO.new(pin, .input)!
}

pub enum DigitalValue {
	low  = C.LOW
	high = C.HIGH
}

interface GPIOWrite {
	write(value DigitalValue)
}

pub fn GPIOWrite.new(pin int) !GPIOWrite {
	return GPIO.new(pin, .output)!
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

pub fn GPIOInterrupt.new(pin int) !GPIOInterrupt {
	return GPIO.new(pin, .interrupt)!
}
