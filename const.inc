	real*8 pi
	parameter (pi=3.14159265358979d0)

	real*8 avog,bolt 
	parameter (avog=6.02214179d23) ! Avogadro number
	parameter (bolt=1.3806504d-23) ! Boltzmann constant

	real*8 y2s,j2ev 
	parameter (y2s=60*60*24*365d0) ! year to second
	parameter (j2ev=1d19/1.602176487d0) ! J to eV