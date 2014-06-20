#FC = g77
FC = gfortran
FFLAGS        = -O
DEST	      = ../lib
LIBRARY	      = libDeltaChi2.a
OBJS = hsimpson1D.o chi2.o MakeHisto1D.o adchi2.o gran.o MakeHisto1D_stat.o

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