F77      = g77
FFLAGS   = -O -ffixed-line-length-132
PHYSHOME = $(PACKAGES)/physlib
#INCLUDES = -I./ -I$(PHYSHOME)/inc
LIBDIR   = -L$(PHYSHOME)/lib 
#-L$(PACKAGES)/fftw_v3.3.2/lib

LIBS_MYLIB = -lmylib

LIBS          = $(LIBS_MYLIB)

OBJS_basic_plots = basic_plots.o funcs.o
OBJS_fft     = fft_nor_inv.o funcs.o

.f.o:
	$(F77) $(FFLAGS) $(INCLUDES) -c $<

basic_plots: $(OBJS_basic_plots)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_basic_plots) $(LIBS) -o $@

fft: $(OBJS_fft)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_fft) $(LIBS) -o $@

clean: 
	@rm *.o *~ check *#