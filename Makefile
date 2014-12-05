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

OBJS_basic_plots = basic_plots.o funcs.o
OBJS_fft         = fft_nor_inv.o funcs.o
OBJS_dchi2       = main.o hfunc1D.o minfunc.o funcs.o smearing.o gran.o get_Ls.o make_bins.o
OBJS_dist       = dist.o make_dist.o fFluxXsec.o funcs.o
OBJS_eventdist       = eventdist.o feventdist.o make_dist.o funcs.o
OBJS_get_cl       = get_cl.o
OBJS_test       = test.o

.f.o:
	$(F77) $(FFLAGS) $(INCLUDES) -c $<

basic_plots: $(OBJS_basic_plots)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_basic_plots) $(LIBS) -o $@

fft: $(OBJS_fft)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_fft) $(LIBS) -o $@

dchi2: $(OBJS_dchi2)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_dchi2) $(LIBS) -o $@

dist: $(OBJS_dist)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_dist) $(LIBS) -o $@

eventdist: $(OBJS_eventdist)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_eventdist) $(LIBS) -o $@

get_cl: $(OBJS_get_cl)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_get_cl) $(LIBS) -o $@

test: $(OBJS_test)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_test) $(LIBS) -o $@

clean: 
	@rm *.o *~ *# fort* basic_plots fft dist dchi2 eventdist

clean_all:
	@rm *.o *~ *# fort* *.dat *.eps basic_plots fft dist dchi2 eventdist