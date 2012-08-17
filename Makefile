F77      = g77
FFLAGS   = -O -ffixed-line-length-132
PHYSHOME = $(PACKAGES)/physlib
INCLUDES = -I./ -I$(PHYSHOME)/inc
LIBDIR   = -L$(PHYSHOME)/lib

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

OBJS     = funcs.o

.f.o:
	$(F77) $(FFLAGS) $(INCLUDES) -c $<

check: $(OBJS)
	 $(F77) $(FFLAGS) $(LIBDIR) $(OBJS) $(LIBS) -o $@

clean: 
	@rm *.o *~ check *#