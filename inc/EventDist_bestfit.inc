C -*- fortran -*-
         xmin = dsqrt(Emin-0.8d0)
         xmax = dsqrt(Emax-0.8d0)
         nbins = 100
         do i = 0,nbins
            x(i) = xmin +( xmax -xmin ) / dble(nbins)*i
         enddo

CCCCCCCCCCCCCCCCCCCCCCCCCCCC  FIT TO NH CASE  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCC                  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
         open(2,file='dchi2min_bestfit2nh.dat',status='old',err=200)
c         do 
            read(2,*) z_min(11),z_min(1),z_min(2),z_min(3)
     &           ,z_min(4),z_min(5)
c            if ((z_min(11).ge.z_dat(11)).and.(z_min(11).lt.z_dat(11)+9d0))
c     &           then
c               minflag = 1
               do i = 6,11
                  z_min(i) = z(i)
               enddo
c               goto 100
c            endif
c         enddo
               close(2)

CCCCCCCCCCCCCCCCCCCCCCCCC  Best fit events output for plots   CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
         hmode = 0
         z_dat(10) = 20
         if (z_dat(11).eq.10) then
            open(1,file="events_nh_10.dat",status="replace")
            open(2,file="events_ih_10.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_nhmin_10_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_nhmin_10_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_nhmin_10_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_nhmin_10_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.20) then
            open(1,file="events_nh_20.dat",status="replace")
            open(2,file="events_ih_20.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_nhmin_20_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_nhmin_20_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_nhmin_20_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_nhmin_20_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.30) then
            open(1,file="events_nh_30.dat",status="replace")
            open(2,file="events_ih_30.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_nhmin_30_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_nhmin_30_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_nhmin_30_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_nhmin_30_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.40) then
            open(1,file="events_nh_40.dat",status="replace")
            open(2,file="events_ih_40.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_nhmin_40_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_nhmin_40_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_nhmin_40_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_nhmin_40_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.50) then
            open(1,file="events_nh_50.dat",status="replace")
            open(2,file="events_ih_50.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_nhmin_50_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_nhmin_50_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_nhmin_50_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_nhmin_50_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.60) then
            open(1,file="events_nh_60.dat",status="replace")
            open(2,file="events_ih_60.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_nhmin_60_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_nhmin_60_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_nhmin_60_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_nhmin_60_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.70) then
            open(1,file="events_nh_70.dat",status="replace")
            open(2,file="events_ih_70.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_nhmin_70_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_nhmin_70_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_nhmin_70_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_nhmin_70_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.80) then
            open(1,file="events_nh_80.dat",status="replace")
            open(2,file="events_ih_80.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_nhmin_80_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_nhmin_80_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_nhmin_80_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_nhmin_80_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.90) then
            open(1,file="events_nh_90.dat",status="replace")
            open(2,file="events_ih_90.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_nhmin_90_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_nhmin_90_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_nhmin_90_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_nhmin_90_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.100) then
            open(1,file="events_nh_100.dat",status="replace")
            open(2,file="events_ih_100.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_nhmin_100_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_nhmin_100_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_nhmin_100_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_nhmin_100_0.75.dat",status="replace")
            endif
         endif
         z_dat(6) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         call smearing(event_dat,nbins,rdx,Eres,event2_dat,iswitch_smear)
c         open(1,file="evdinhmin.dat",status="replace")
c         open(1,file="events_nh_"//z_dat(11)//".dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo

         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         call smearing(event_dat,nbins,rdx,Eres,event2_dat,iswitch_smear)
c         open(1,file="evdinhmin.dat",status="replace")
c         open(1,file="events_"//z_dat(11)//".dat",status="replace")
         do i = 1,nbins
            write(2,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo

         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         call smearing(event_dat,nbins,rdx,Eres,event2_dat,iswitch_smear)
c         open(1,file="events_nhmin_"//z_min(11)//"_"//int(Eres*100)//
c     &        ".dat",status="replace")
         do i = 1,nbins
            write(3,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo

         close(1)
         close(2)
         close(3)

CCCCCCCCCCCCCCCCCCCCCCCCC  Best fit event histogram output   CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
c         hmode = 1
c         xmin = dsqrt(Emin-0.8d0)
c         xmax = dsqrt(Emax-0.8d0)
c         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
c         do i = 0,nbins
c            x(i) = xmin +Eres/2d0*i
c         enddo
c         z_dat(6) = 1
c         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
c     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
c     &        ,nevent_dat,ierr1)
c         z_dat(6) = -1
c         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
c     &        ,evform_th,serror,snmax,hmode,event_th,hevent_th
c     &        ,nevent_th,ierr2)
c         z_min(6) = -1
c         call MakeHisto1D(nout,hfunc1D,z_min,nevent,nbins,x
c     &        ,evform_th,serror,snmax,hmode,event_fit,hevent_fit
c     &        ,nevent_fit,ierr2)
c         open(1,file="event_min2nh.dat",status="replace")
c         do i = 1,nbins
c            write(1,*) x(i-1)**2+0.8d0,event_dat(i),event_th(i),event_fit(i)
c         enddo
c         close(1)
 200  continue


CCCCCCCCCCCCCCCCCCCCCCCCCCCC  FIT TO NH CASE  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCC                  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
         open(2,file='dchi2min_bestfit2ih.dat',status='old',err=400)
c         do 
            read(2,*) z_min(11),z_min(1),z_min(2),z_min(3)
     &           ,z_min(4),z_min(5)
c            if ((z_min(11).ge.z_dat(11)).and.(z_min(11).lt.z_dat(11)+9d0))
c     &           then
c               minflag = 1
               do i = 6,11
                  z_min(i) = z(i)
               enddo
c               goto 100
c            endif
c         enddo
               close(2)
CCCCCCCCCCCCCCCCCCCCCCCCC  Best fit events output for plots   CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
         hmode = 0
         z_dat(10) = 20

         if (z_dat(11).eq.10) then
c            open(1,file="events_nh_10.dat",status="replace")
c            open(2,file="events_ih_10.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_ihmin_10_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_ihmin_10_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_ihmin_10_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_ihmin_10_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.20) then
c            open(1,file="events_nh_20.dat",status="replace")
c            open(2,file="events_ih_20.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_ihmin_20_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_ihmin_20_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_ihmin_20_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_ihmin_20_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.30) then
c            open(1,file="events_nh_30.dat",status="replace")
c            open(2,file="events_ih_30.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_ihmin_30_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_ihmin_30_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_ihmin_30_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_ihmin_30_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.40) then
c            open(1,file="events_nh_40.dat",status="replace")
c            open(2,file="events_ih_40.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_ihmin_40_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_ihmin_40_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_ihmin_40_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_ihmin_40_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.50) then
c            open(1,file="events_nh_50.dat",status="replace")
c            open(2,file="events_ih_50.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_ihmin_50_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_ihmin_50_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_ihmin_50_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_ihmin_50_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.60) then
c            open(1,file="events_nh_60.dat",status="replace")
c            open(2,file="events_ih_60.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_ihmin_60_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_ihmin_60_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_ihmin_60_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_ihmin_60_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.70) then
c            open(1,file="events_nh_70.dat",status="replace")
c            open(2,file="events_ih_70.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_ihmin_70_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_ihmin_70_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_ihmin_70_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_ihmin_70_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.80) then
c            open(1,file="events_nh_80.dat",status="replace")
c            open(2,file="events_ih_80.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_ihmin_80_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_ihmin_80_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_ihmin_80_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_ihmin_80_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.90) then
c            open(1,file="events_nh_90.dat",status="replace")
c            open(2,file="events_ih_90.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_ihmin_90_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_ihmin_90_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_ihmin_90_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_ihmin_90_0.75.dat",status="replace")
            endif
         elseif (z_dat(11).eq.100) then
c            open(1,file="events_nh_100.dat",status="replace")
c            open(2,file="events_ih_100.dat",status="replace") 
            if (Eres.eq.0.06) then
               open(3,file="events_ihmin_100_6.dat",status="replace") 
            elseif (Eres.eq.0.03) then
               open(3,file="events_ihmin_100_3.dat",status="replace") 
            elseif (Eres.eq.0.015) then
               open(3,file="events_ihmin_100_1.5.dat",status="replace") 
            elseif (Eres.eq.0.075) then
               open(3,file="events_ihmin_100_0.75.dat",status="replace")
            endif
         endif

c         z_dat(6) = 1
c         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
c     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
c     &        ,nevent_dat,ierr)
c         call smearing(event_dat,nbins,rdx,Eres,event2_dat,iswitch_smear)
c         open(1,file="evdinhmin.dat",status="replace")
c         open(1,file="events_nh_"//z_dat(11)//".dat",status="replace")
c         do i = 1,nbins
c            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
c         enddo

c         z_dat(6) = -1
c         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
c     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
c     &        ,nevent_dat,ierr)
c         call smearing(event_dat,nbins,rdx,Eres,event2_dat,iswitch_smear)
c         open(1,file="evdinhmin.dat",status="replace")
c         open(1,file="events_"//z_dat(11)//".dat",status="replace")
c         do i = 1,nbins
c            write(2,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
c         enddo

         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         call smearing(event_dat,nbins,rdx,Eres,event2_dat,iswitch_smear)
c         open(1,file="events_nhmin_"//z_min(11)//"_"//int(Eres*100)//
c     &        ".dat",status="replace")
         do i = 1,nbins
            write(3,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo

         close(1)
         close(2)
         close(3)

 400  continue
