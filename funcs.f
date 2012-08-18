      program neu_event
      implicitnone

      integer i,ndiv,sign,mode
      parameter (ndiv=1000)
      integer*8 plan1,FFTW_ESTIMATE,plan2
      real*8 Emin,Emax,event21(ndiv),event0_nor(ndiv),L,E,El,vol,prob2
      real*8 event0_inv(ndiv),no_osc(ndiv)
      real*8 loemin,loemax,loe
      complex*16 event0_nor_out(ndiv/2+1),event0_inv_out(ndiv/2+1)
      real*8 flux,xsec,prob_ee,flux_norm,xsec_norm,Elmax,Elmin,scale
      external flux,xsec,prob_ee

c      E = 6d0
      L = 60d0

      call dfftw_plan_dft_r2c_1d(plan1,ndiv,event0_nor,event0_nor_out,FFTW_ESTIMATE)
      call dfftw_plan_dft_r2c_1d(plan2,ndiv,event0_inv,event0_inv_out,FFTW_ESTIMATE)

      open(10,file="events.dat",status="replace")
      open(11,file="prob.dat",status="replace")
      open(12,file="prob2.dat",status="replace")
      open(13,file="fig1.dat",status="replace")
      open(14,file="events2.dat",status="replace")
      open(15,file="events3.dat",status="replace")

      do i = 1,ndiv
         loemin = 5d0
         loemax = 40d0
         loe = loemin +(loemax -loemin)/dble(ndiv)*(i-1)
         E = L/loe
c         L = loe*E
         event21(i) = flux(E)*xsec(E)*prob_ee(loe,1,21)
         event0_nor(i) = flux(E)*xsec(E)*prob_ee(loe,1,0)
         event0_inv(i) = flux(E)*xsec(E)*prob_ee(loe,-1,0)
         no_osc(i) = flux(E)*xsec(E)
         prob2 = 1d0 -prob_ee(loe,-1,0)/prob_ee(loe,1,0)
         write(10,*) loe,event21(i),event0_nor(i),event0_inv(i)
         write(11,*) E,prob_ee(loe,1,0),prob_ee(loe,-1,0)
         write(12,*) E,prob2
         write(13,*) loe,prob_ee(loe,1,21),prob_ee(loe,1,0),prob_ee(loe,-1,0)
         write(14,*) loe,no_osc(i)
         write(15,*) E,no_osc(i)
      enddo
      close(10)
      close(11)
      close(12)
      close(13)
      close(14)
      close(15)

c      call dfftw_execute_dft_r2c(plan, event1, event1_out)
      call dfftw_execute(plan1)
      call dfftw_execute(plan2)
      call dfftw_destroy_plan(plan1)
      call dfftw_destroy_plan(plan2)

      scale = 1d0/ndiv
      open(10,file="event0_nor_fft.dat",status="replace")
      do i = 1,ndiv/2+1
c         write(10,'(i5,2e16.8)') i,dble(event0_nor_out(i))*scale,imag(event0_nor_out(i))*scale
         write(10,*) i,dble(event0_nor_out(i))*scale,imag(event0_nor_out(i))*scale
      enddo
      close(10)
      open(10,file="event0_inv_fft.dat",status="replace")
      do i = 1,ndiv/2+1
c         write(10,'(i5,2e16.8)') i,dble(event0_inv_out(i))*scale,imag(event0_inv_out(i))*scale
         write(10,*) i,dble(event0_inv_out(i))*scale,imag(event0_inv_out(i))*scale
      enddo
      close(10)

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
      real*8 E,Ee
C     ----------
C     BEGIN CODE
C     ----------
      c = 3*10**8
      me = 0.510998910d0

c      Ee = E
      Ee = E -1.2913d0
      xsec = 0.0952d0*Ee*dsqrt(Ee**2 -me**2)*1d-42
c      xsec = 0.0952d0*Ee**4*1d-42

      return
      end


      real*8 function prob_ee(a,sign,mode)
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
      integer sign,mode
      real*8 a,aa
C     ----------
C     BEGIN CODE
C     ----------
      s2sun_2 = 0.852d0
      s23_2 = 0.5d0
      s213_2 = 0.1d0 
      dm13_2 = 2.35d-3
      dm12_2 = 7.5d-5
      dm23_2 = sign*dm13_2 -dm12_2

c      s13 = dsqrt( (1d0 -dsqrt(1d0 -s213_2))/2d0 )
      s13 = dsqrt( 0.5*s213_2/( 1d0 +dsqrt(1d0 -s213_2) ) )
      c13 = dsqrt(1d0 -s13**2)
      s12 = dsqrt( (1d0 -dsqrt(1d0 -s2sun_2/c13**4))/2d0 )
      c12 = dsqrt(1d0 -s12**2)
      ue1 = c12*c13
      ue2 = s12*c13
      ue3 = s13

      dim_fact = 1d6/197.3269631d0
      aa = a*dim_fact

      if (mode.eq.0) then
         prob_ee = 1d0 -4*ue1**2*ue2**2*dsin(dm12_2*aa/4d0)**2
     &        -4*ue1**2*ue3**2*dsin(dm13_2*aa/4d0)**2
     &        -4*ue2**2*ue3**2*dsin(dm23_2*aa/4d0)**2
      elseif (mode.eq.21) then
         prob_ee = 1d0 -4*ue1**2*ue2**2*dsin(dm12_2*aa/4d0)**2
      elseif (mode.eq.31) then
         prob_ee = -4*ue1**2*ue3**2*dsin(dm13_2*aa/4d0)**2
      elseif (mode.eq.32) then
         prob_ee = -4*ue2**2*ue3**2*dsin(dm23_2*aa/4d0)**2
      endif

      return
      end
