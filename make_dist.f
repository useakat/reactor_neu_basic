      subroutine make_dist(f,z,xmin,xmax,ndiv,hmode,evform,nevent,serror
     &     ,snmax,norm,filename)
      implicitnone

      integer i
      integer nevent,snmax,hmode,evform,nout,norm,indiv
      real*8 serror,z(20),xmin,xmax,ndiv
      character*10 filename

      real*8 hevent(ndiv),x(0:ndiv),event(ndiv),nevent_out

      real*8 f
      external f

      nout = 99

      indiv = idnint(ndiv)

      do i = 0,indiv
         x(i) = xmin +(xmax -xmin)/dble(ndiv)*i
      enddo
      call MakeHisto1D(nout,f,z,nevent,indiv,x,evform
     &     ,serror,snmax,hmode,event,hevent,nevent_out)

      if (hmode.eq.0) norm = 1
      open(1,file=filename,status="replace")      
      if (norm.eq.1) then
         do i = 1,indiv
            write(1,*) x(i),hevent(i)
         enddo
      elseif (norm.eq.2) then
         do i = 1,indiv
            write(1,*) x(i),event(i)
         enddo
      endif
      close(1)
      write(*,*) "nevent_makedist =",nevent_out

      return
      end
