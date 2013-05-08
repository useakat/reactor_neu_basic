C -*- fortran -*-
      if (multi_flag.eq.0) then
         z(15) = 20
         z_dat(15) = z(15)         ! N vs. sqrt(E)
      elseif (multi_flag.eq.1) then
         z(15) = 25
         z_dat(15) = z(15)         ! RENO50 multi-reactor: N vs. sqrt(E)
      elseif (multi_flag.eq.2) then
         z(15) = 26
         z_dat(15) = z(15)         ! Korean multi-reactor: N vs. sqrt(E)
      endif
         hmode = 1 ! 0:continuous 1:simpson 2:center-value 
         evform_dat = 2
         evform_th = 2
c         include 'bining_dx.inc'
         include 'bining_Eres2.inc'

         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr1) 
c         call smearing(event_dat,nbins,rdx,Eres,event2_dat)         
c         call smearing_nl(event_dat,x,nbins,rdx,Eres,Eres_nl,event2_dat)         
         call smearing_nl2(event_dat,x,nbins,Eres,Eres_nl,event2_dat)         
        
         call MakeHisto1D(nout,hfunc1D,z,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &        ,nevent_th,ierr2)
c         call smearing(event_th,nbins,rdx,Eres,event2_th)
         EEres = Eres*z(7)
         EEres_nl = Eres_nl*z(8)
c         call smearing_nl(event_th,x,nbins,rdx,EEres,EEres_nl,event2_th)         
         call smearing_nl2(event_th,x,nbins,EEres,EEres_nl,event2_th)         

c            dchisq = dchi2(nout,event2_dat,event2_th,nbins,npar,z,z_dat
c     &           ,error)  
c         write(19,*) z
c         write(19,*) z_dat
c         write(19,*) nevent_dat,nevent_th
c         do i = 1,nbins
c            write(19,*) i,event_dat(i),event_th(i)
c         enddo
c         write(19,*)
            chisq_wrong = chi2_2(nout,event2_dat,event2_th,x,nbins,npar,z
c            chisq_wrong = chi2_2(nout,event_dat,event_th,x,nbins,npar,z
     &        ,z_dat,error)  
c            write(6,*) npar
c            write(6,*) z(1),z(2),z(3),z(4),z(5),z(6),z(7)
c            write(6,*) z_dat(1),z_dat(2),z_dat(3),z_dat(4),z_dat(5),z_dat(6),z_dat(7)
c            write(6,*) error(1),error(2),error(3),error(4),error(5),error(6),error(7)            

            dchisq = chisq_wrong
