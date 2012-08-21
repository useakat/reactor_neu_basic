F77      = g77
FFLAGS   = -O -ffixed-line-length-132
PHYSHOME = $(PACKAGES)/physlib
INCLUDES = -I./ -I$(PHYSHOME)/inc
LIBDIR   = -L$(PHYSHOME)/lib -L$(PACKAGES)/fftw_v3.3.2/lib

LIBS_SM = -lsmlib
LIBS_HML = -lhml -lhmlutil
LIBS_HELAS = -ldhelas3 -ldhelas5 
LIBS_MYLIB = -lmylib
LIBS_BASES = -lbases50_xhsave
LIBS_LIB = -llibrary

LIBS          = $(LIBS_SM) \
		$(LIBS_HML) \
		$(LIBS_HELAS) \
		$(LIBS_LIB) \
		$(LIBS_BASES) \
		$(LIBS_MYLIB)

OBJS_funcs     = funcs2.o funcs.o
OBJS_fft     = fft_nor_inv.o funcs.o

.f.o:
	$(F77) $(FFLAGS) $(INCLUDES) -c $<

funcs: $(OBJS_funcs)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_funcs) $(LIBS) -o $@

fft: $(OBJS_fft)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS_fft) $(LIBS) -o $@

clean: 
	@rm *.o *~ check *#