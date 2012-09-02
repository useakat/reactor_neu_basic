F77      = g77
FFLAGS   = -O -ffixed-line-length-132
#PHYSHOME = ./
#INCLUDES = -I./ -I$(PHYSHOME)/inc
LIBDIR   = -L./lib
#-L$(PACKAGES)/fftw_v3.3.2/lib

LIBS_MYLIB = -lmylib -lminuit -lDeltaChi2

LIBS          = $(LIBS_MYLIB)

OBJS_basic_plots = basic_plots.o funcs.o
OBJS_fft         = fft_nor_inv.o funcs.o
OBJS_dchi2       = test2.o hfunc1D.o minfunc.o funcs.o
OBJS_dist       = dist.o make_dist.o hfunc1D.o funcs.o
OBJS_eventdist       = eventdist.o feventdist.o make_dist.o funcs.o

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

clean: 
	@rm *.o *~ test fft basic_plots *# fort*

clean_all:
	@rm *.o *~ test fft basic_plots *# fort* *.dat *.eps