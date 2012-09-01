FC = g77
FFLAGS        = -O
DEST	      = ../lib
LIBRARY	      = libminuit.a
OBJS =  stand.o mnamin.o mnbins.o mncalf.o mncler.o mncntr.o mncomd.o mncont.o mncrck.o \
	mncros.o mncuve.o mnderi.o mndxdi.o mneig.o mnemat.o mnerrs.o mneval.o mnexcm.o \
	mnexin.o mnfixp.o mnfree.o mngrad.o mnhelp.o mnhes1.o mnhess.o mnimpr.o mninex.o \
	mninit.o mninpu.o mnintr.o mnlims.o mnline.o mnmatu.o mnmigr.o mnmnos.o mnmnot.o \
	mnparm.o mnpars.o mnpfit.o mnpint.o mnplot.o mnpout.o mnprin.o mnpsdf.o mnrazz.o \
	mnread.o mnrn15.o mnrset.o mnsave.o mnscan.o mnseek.o mnset.o mnseti.o mnsimp.o \
	mnstat.o mnstin.o mntiny.o mnunpt.o mnvers.o mnvert.o mnwarn.o mnwerr.o minuit.o 

install:	$(LIBRARY)
	        @echo Installing $(LIBRARY) in $(DEST)
	        @if [ $(DEST) != . ]; then \
	        (rm -f $(DEST)/$(LIBRARY); install -c $(LIBRARY) $(DEST)); fi

$(LIBRARY):	$(OBJS)
		@echo  "Loading $(LIBRARY) ... "
		@ar cru $(LIBRARY) $(OBJS)
		@echo "done"

clean:
	rm -f *.o *.a *~