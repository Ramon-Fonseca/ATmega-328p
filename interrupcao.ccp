
#define F_CPU 16000000UL
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>


#define set_bit(y,bit_x) (y|=(1<<bit_x))
#define clr_bit(y,bit_x) (y&=~(1<<bit_x))
#define cpl_bit(y,bit_x) (y^=(1<<bit_x))
#define tst_bit(y,bit_x) (y&(1<<bit_x))
#define LED0 PD5
#define LED1 PD6
#define LED2 PD7

ISR(PCINT1_vect);
int main()
{
	DDRC = 0x00;
	PORTC = 0xFF;
	DDRD = 0b11100000;
	PORTD = 0xFF;
	PCICR = 1<<PCIE1;
	PCMSK1 = (1<<PCINT10)|(1<<PCINT9)|(1<<PCINT8);
	
	sei();
	while(1){}
}
ISR(PCINT1_vect)
{
	
	if(!tst_bit(PINC,PC0))
	cpl_bit(PORTD,LED0);
	else if(!tst_bit(PINC,PC1))
	cpl_bit(PORTD,LED1);
	else if(!tst_bit(PINC,PC2))
	cpl_bit(PORTD,LED2);
	_delay_ms(200);
}

