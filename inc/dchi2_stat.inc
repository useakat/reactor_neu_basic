C     -*- fortran -*-
      if (multi_flag.eq.0) then
         z(15) = 20
         z_dat(15) = z(15)      ! N vs. sqrt(E)
      elseif (multi_flag.eq.1) then
         z(15) = 25
         z_dat(15) = z(15)      ! RENO50 multi-reactor: N vs. sqrt(E)
      elseif (multi_flag.eq.2) then
         z(15) = 26
         z_dat(15) = z(15)      ! Korean multi-reactor: N vs. sqrt(E)
      endif
      hmode = 1                 ! 0:continuous 1:simpson 2:center-value 
      evform_dat = 2
      evform_th = 2
      include 'bining_dx.inc'
c     include 'bining_Eres2.inc'
      
      if (ifirst.eq.0) then
c     call MakeHisto1D_stat(nout,hfunc1D,z_dat,nevent,nbins,x
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr1) 
c     call smearing(event_dat,nbins,rdx,Eres,event2_dat)         
         call smearing_nl(event_dat,x,nbins,rdx,Eres,Eres_nl,event2_dat)         
c     call smearing_nl2(event_dat,x,nbins,EEres,EEres_nl,event2_dat)         
         do i = 1,nbins
            event2_dat(i) = event2_dat(i) +dsqrt(event2_dat(i))*gran()
            if (event2_dat(i).lt.0) event2_dat(i) = 0
         enddo
         ifirst = 1
      endif
      
      call MakeHisto1D(nout,hfunc1D,z,nevent,nbins,x
     &     ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &     ,nevent_th,ierr2)
c     call smearing(event_th,nbins,rdx,Eres,event2_th)
      call smearing_nl(event_th,x,nbins,rdx,Eres,Eres_nl,event2_th)         
c      call smearing_nl2(event_th,x,nbins,EEres,EEres_nl,event2_th)         
      
c     dchisq = chi2_2(nout,event2_dat,event2_th,nbins,npar,z,z_dat
c     &           ,error)  
      dchisq = chi2_2(nout,event2_dat,event2_th,x,nbins,npar,z
     &     ,z_dat,error)  
      
c     dchisq = chisq_wrong -chisq_true
c     dchisq = chisq_wrong
