F77      = g77
FFLAGS   = -O -ffixed-line-length-132
PHYSHOME = $(PACKAGES)/physlib
#INCLUDES = -I./ -I$(PHYSHOME)/inc
LIBDIR   = -L$(PHYSHOME)/lib 
#-L$(PACKAGES)/fftw_v3.3.2/lib

LIBS_MYLIB = -lmylib -lminuit

LIBS          = $(LIBS_MYLIB)

OBJS_basic_plots = basic_plots.o funcs.o
OBJS_fft     = fft_nor_inv.o funcs.o
#OBJS_test     = test.o
#OBJS_test     = test2.o test_func.o MakeHisto1D.o
OBJS_test     = test2.o hfunc1D.o MakeHisto1D.o dchi2.o hsimpson1D.o minfunc.o funcs.o

.f.o:
	$(F77) $(FFLAGS) $(INCLUDES) -c $<

basic_plots: $(OBJS_basic_plots)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_basic_plots) $(LIBS) -o $@

fft: $(OBJS_fft)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_fft) $(LIBS) -o $@

test: $(OBJS_test)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_test) $(LIBS) -o $@

clean: 
	@rm *.o *~ test fft basic_plots *# fort*