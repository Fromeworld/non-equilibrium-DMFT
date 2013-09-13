FC=/opt/mpich2/intel/bin/mpif90
EXE   = neqDMFT
DIREXE= $(HOME)/.bin

#=========================================================================
include sfmake.inc
#=========================================================================

.SUFFIXES: .f90 
OBJS =  CONTOUR_GF.o VARS_GLOBAL.o ELECTRIC_FIELD.o BATH.o  IPT_NEQ.o FUNX_NEQ.o KADANOFBAYM.o
BRANCH=  $(shell git rev-parse --abbrev-ref HEAD)
#=================STANDARD COMPILATION====================================
FLAG=$(STD)
ARGS=$(SFLIBS)

compile: version $(OBJS)
	@echo " ..................... compile ........................... "
	$(FC) $(FLAG) $(OBJS) $(EXE).f90 -o $(DIREXE)/$(EXE)_$(BRANCH) $(ARGS)
	@echo " ...................... done .............................. "
	@echo ""
	@echo ""
	@echo "created" $(DIREXE)/$(EXE)_$(BRANCH)



#==============DATA EXTRACTION======================================
data:	FLAG=$(STD)
	ARGS=$(LIBDMFT) $(SFMODS) $(SFLIBS) #$(DSL_MODS) $(DSL_LIBS)
	BRANCH=  $(shell git rev-parse --abbrev-ref HEAD)
data: 	version $(OBJS)
	@echo " ........... compile: getdata ........... "
	${FC} ${FLAG} $(OBJS) get_data_$(EXE).f90 -o ${DIREXE}/get_data_$(EXE)_$(BRANCH) $(ARGS) 
	@echo ""
	@echo " ...................... done .............................. "



.f90.o:	
	$(FC) $(FLAG) -c $< $(SFINCLUDE) 



#=============CLEAN ALL===================================================
clean: 
	@echo "Cleaning:"
	@rm -f *.mod *.o *~ revision.inc

version:
	@echo $(VER)
#=========================================================================
#include version.mk
#=========================================================================
