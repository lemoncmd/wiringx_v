module wiringx

fn C.wiringXValidGPIO(pin int) int
fn C.pinMode(pin int, mode PinMode)
fn C.digitalRead(pin int) int
fn C.digitalWrite(pin int, value DigitalValue) int
fn C.waitForInterrupt(pin int, ms int) int
fn C.wiringXISR(pin int, mode ISRMode) int

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
	return C.digitalRead(g.pin)
}

fn (g GPIO) write(value DigitalValue) {
	C.digitalWrite(g.pin, value)
}

fn (g GPIO) set_isr(mode ISRMode) {
	C.wiringXISR(g.pin, mode)
}

fn (g GPIO) wait_for_interrupt(timeout_ms int) {
	C.waitForInterrupt(g.pin, timeout_ms)
}

interface GPIORead {
	read() int
}

// get GPIO for reading
pub fn GPIORead.new(pin int) !GPIORead {
	return GPIO.new(pin, .input)!
}

// digital value
pub enum DigitalValue {
	low  = C.LOW
	high = C.HIGH
}

interface GPIOWrite {
	write(value DigitalValue)
}

// get GPIO for writing
pub fn GPIOWrite.new(pin int) !GPIOWrite {
	return GPIO.new(pin, .output)!
}

// interrupt mode
pub enum ISRMode {
	rising  = C.ISR_MODE_RISING
	falling = C.ISR_MODE_FALLING
	both    = C.ISR_MODE_BOTH
}

interface GPIOInterrupt {
	set_isr(mode ISRMode)
	wait_for_interrupt(timeout_ms int)
}

// get GPIO for interrupt
pub fn GPIOInterrupt.new(pin int) !GPIOInterrupt {
	return GPIO.new(pin, .interrupt)!
}
