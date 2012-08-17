      program neu_event
      implicitnone

      integer i,ndiv
      real*8 Emin,Emax,event1,event2,L,E,vol,prob2
      real*8 flux,xsec,prob_ee,flux_norm,xsec_norm
      external flux,xsec,prob_ee

      L = 60d0

      open(10,file="events.dat",status="replace")
      open(11,file="prob.dat",status="replace")
      open(12,file="prob2.dat",status="replace")

      Emin = 1d0
      Emax = 9d0
      ndiv = 10000
      vol = 1d30
      flux_norm = 5d20

      do i = 0,ndiv
         E = Emin +(Emax -Emin)/dble(ndiv)*i
         event1 = vol*flux(E)*flux_norm*xsec(E)*prob_ee(L/E,1)
     &        /L**2
         event2 = vol*flux(E)*flux_norm*xsec(E)*prob_ee(L/E,-1)
     &        /L**2
         prob2 = 1d0 -prob_ee(L/E,-1)/prob_ee(L/E,1)
         write(10,*) E,event1,event2
         write(11,*) E,prob_ee(L/E,1),prob_ee(L/E,-1)
         write(12,*) E,prob2
         write(20,*) prob_ee(L/E,1)
      enddo
      close(10)
      close(11)
      close(12)

      end

      real*8 function flux(E)
C     ****************************************************
C     
C     By Yoshitaro Takaesu @KEK Nov.19 2011
C     
C     The driver for making include and dat files for QCD
C     processes in color-flow-sampling option of MG. 
C     Input:
C     pp    4 momentum of external particles
C     Output:
C     Amplitude squared and summed
C     ****************************************************
      implicitnone
C     
C     ARGUMENTS 
C     
      integer neu_per_s 
      real*8 E
C     ----------
C     BEGIN CODE
C     ----------
c      neu_per_s = 5*10**20 

      flux = 0.58*dexp( 0.870d0 -0.160*E -0.091*E**2 )
     &      +0.30*dexp( 0.896d0 -0.239*E -0.0981*E**2 )
     &      +0.07*dexp( 0.976d0 -0.162*E -0.0790*E**2 )
     &      +0.05*dexp( 0.793d0 -0.080*E -0.1085*E**2 )

      return
      end


      real*8 function xsec(E)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Aug.17 2012
C     
C     Cross section between electron neutrino and detector in cm^2 unit.
C     Ref: hep-ph/9903554 eq.11
C
C     input
C           E: energy of the positron in MeV           
C     ****************************************************
      implicitnone
C
C     CONSTANTS
C
      real*8 c,me
C     
C     ARGUMENTS 
C     
      real*8 E
C     ----------
C     BEGIN CODE
C     ----------
      c = 3*10**8
      me = 0.510998910d0

      xsec = 0.0952*E*dsqrt(E**2 -me**2)*1d-42

      return
      end


      real*8 function prob_ee(a,sign)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Aug.17 2012
C     
C     P_ee
C
C     input
C           a: L/E in km/MeV
C     ****************************************************
      implicitnone
C
C     CONSTANTS
C
      real*8 s2sun_2,s23_2,s213_2,s12,c12,s13,c13
      real*8 dm13_2,dm12_2,dm23_2
      real*8 ue1,ue2,ue3,ue1ue2,ue1ue3,ue2ue3
      real*8 dim_fact
C     
C     ARGUMENTS 
C     
      integer sign
      real*8 a,aa
C     ----------
C     BEGIN CODE
C     ----------
      s2sun_2 = 0.852d0
      s23_2 = 0.5d0
      s213_2 = 0.1d0 
      if (sign.eq.1) dm13_2 = 2.35d-3
      if (sign.eq.-1) dm13_2 = -2.35d-3
      dm12_2 = 7.5d-5
      dm23_2 = dm13_2 -dm12_2

c      s13 = dsqrt( (1d0 -dsqrt(1d0 -s213_2))/2d0 )
      s13 = dsqrt( 0.5*s213_2/( 1d0 +dsqrt(1d0 -s213_2) ) )
      c13 = dsqrt(1d0 -s13**2)
      s12 = dsqrt( (1d0 -dsqrt(1d0 -s2sun_2/c13**4))/2d0 )
c      s12 = dsqrt( 0.5*s2sun_2/( 1d0 +dsqrt(1d0 -s2sun_2/c13**4) ) )
      c12 = dsqrt(1d0 -s12**2)
      ue1 = c12*c13
      ue2 = s12*c13
      ue3 = s13

      dim_fact = 1d6/197.3269631d0
      aa = a*dim_fact

      prob_ee = 1d0 -4*ue1**2*ue2**2*dsin(dm12_2*aa/4d0)**2
     &          -4*ue1**2*ue3**2*dsin(dm13_2*aa/4d0)**2
     &          -4*ue2**2*ue3**2*dsin(dm23_2*aa/4d0)**2

c      prob_ee = s12**2

      return
      end
