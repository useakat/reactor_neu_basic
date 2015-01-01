#F77      = g77
F77      = gfortran
FFLAGS   = -O -ffixed-line-length-132
#PHYSHOME = ./
#INCLUDES = -I./ -I$(PHYSHOME)/inc
LIBDIR   = -L./lib
#-L$(PACKAGES)/fftw_v3.3.2/lib

#LIBS_MYLIB = -lmylib -lminuit -lDeltaChi2 -lquadpack
LIBS_MYLIB = -lmylib -lminuit -lDeltaChi2

LIBS          = $(LIBS_MYLIB)

OBJS_dchi2       = main.o hfunc1D.o minfunc.o funcs.o smearing.o gran.o get_Ls.o make_bins.o

.f.o:
	$(F77) $(FFLAGS) $(INCLUDES) -c $<

dchi2: $(OBJS_dchi2)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_dchi2) $(LIBS) -o $@

clean: 
	@rm *.o *~ *# fort* basic_plots fft dist dchi2 eventdist

clean_all:
	@rm *.o *~ *# fort* *.dat *.eps basic_plots fft dist dchi2 eventdist