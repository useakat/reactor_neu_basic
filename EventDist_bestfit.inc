         open(2,file='dchi2min_bestfit2nh.dat',status='old',err=200)
         do 
            read(2,*,end=100) z_min(11),z_min(1),z_min(2),z_min(3)
     &           ,z_min(4),z_min(5)
            if ((z_min(11).ge.z_dat(11)).and.(z_min(11).lt.z_dat(11)+0.9d0))
     &           then
               minflag = 1
               do i = 6,11
                  z_min(i) = z(i)
               enddo
               goto 100
            endif
         enddo
 100     close(2)
         xmin = dsqrt(Emin-0.8d0)
         xmax = dsqrt(Emax-0.8d0)
         nbins = 100
         do i = 0,nbins
            x(i) = xmin +( xmax -xmin ) / dble(nbins)*i
         enddo
         hmode = 0
         evform_dat = 2   ! 1:integer 2:real*8
         z_min(6) = 1
c         z_dat(6) = 1
         call MakeHisto1D(nout,hfunc1D,z_min,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="evdinhmin.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)
         
         hmode = 1
         xmin = dsqrt(Emin-0.8d0)
         xmax = dsqrt(Emax-0.8d0)
         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +Eres/2d0*i
         enddo
         z_dat(6) = 1
         evform_dat = 2
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr1)
         z_dat(6) = -1
         evform_th = 2
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &        ,nevent_th,ierr2)
         z_min(6) = -1
         evform_th = 2
         call MakeHisto1D(nout,hfunc1D,z_min,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_fit,hevent_fit
     &        ,nevent_fit,ierr2)
         open(1,file="event_min2nh.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i-1)**2+0.8d0,event_dat(i),event_th(i),event_fit(i)
         enddo
         close(1)
 200  continue

      open(2,file='dchi2min_bestfit2ih.dat',status='old',err=400)
      do 
         read(2,*,end=300) z_min(11),z_min(1),z_min(2),z_min(3)
     &        ,z_min(4),z_min(5)
         if ((z_min(11).ge.z_dat(11)).and.(z_min(11).lt.z_dat(11)+1d0))
     &        then
            minflag = 1
            do i = 6,11
               z_min(i) = z(i)
            enddo
            goto 300
         endif
      enddo
 300  close(2)
c      z_min(6) = -1
      z_dat(6) = 1
      call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &     ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &     ,nevent_dat,ierr)
      open(1,file="evdiihmin.dat",status="replace")
      do i = 1,nbins
         write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
      enddo
      close(1)
      
      hmode = 1
      xmin = dsqrt(Emin-0.8d0)
      xmax = dsqrt(Emax-0.8d0)
      nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
      do i = 0,nbins
         x(i) = xmin +Eres/2d0*i
      enddo
      z_dat(6) = 1
      evform_dat = 2
      call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &     ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &     ,nevent_dat,ierr1)
      do i =1,nbins
      enddo
      z_dat(6) = -1
      evform_th = 2
      call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &     ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &     ,nevent_th,ierr2)
      z_min(6) = 1
      evform_th = 2
      call MakeHisto1D(nout,hfunc1D,z_min,nevent,nbins,x
     &     ,evform_th,serror,snmax,hmode,event_fit,hevent_fit
     &     ,nevent_fit,ierr2)
      open(1,file="event_min2ih.dat",status="replace")
      do i = 1,nbins
         write(1,*) x(i-1)**2+0.8d0,event_dat(i),event_th(i),event_fit(i)
      enddo
      close(1)
 400  continue