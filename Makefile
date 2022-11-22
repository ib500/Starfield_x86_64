#################################################################
####### DEFINED MACROS
#################################################################

##COMPILE MACRO##################################################
# For the compile line to be auto filled
# $(1) : Compiler					: Can use either C or C++ compiler
# $(2) : Object file to generate	: obj/*.o
# $(3) : Source file				: src/*.c/.cpp
# $(4) : Additional dependecies		: src/*.h/.hpp
# $(5) : Compiler flags				: Flags for the compile command
define COMPILE
$(2) : $(3) $(4)
	$(1) -c -o  $(2)  $(3)
endef
##CHANGE C/CPP TO O##############################################
# For changing list of .c/.cpp files to .o and move them to the obj folder
# $(1) : Source file	: src/*.c/.cpp
define S2O
$(patsubst %.s,%.o,$(patsubst $(SRC)%,$(OBJ)%,$(1)))
endef


#################################################################
####### CONFIG
#################################################################

##MACROS FOR VARIADIC ELEMENTS###################################
APP     	:= starfield 
C 			:= gcc
AS			:= gcc
MKDIR   	:= mkdir -p
SRC     	:= src
OBJ     	:= obj
LIBDIR		:= libs
INCDIRS		:= -I$(SRC) -I$(LIBDIR) -I$(LIBS) -Ilibs/fmod/inc
LINKFLAGS 	:= -nostartfiles -static

ifdef RELEASE
	CCFLAGS += -O3
	CFLAGS	+= -O3
else
	CCFLAGS += -g
	CFLAGS	+= -g
endif

##MACROS TO CREATE BASIC UTILITIES################################
ALLS	   := $(shell find $(SRC)/ -type f -iname *.s)
ALLOBJ     := $(foreach F,$(ALLS), $(call S2O, $(F)))
SUBDIRS    := $(shell find $(SRC) -type d)
OBJSUBDIRS := $(patsubst $(SRC)%,$(OBJ)%,$(SUBDIRS))

##ONE TIME USE DECLARATION########################################
.PHONY: info clean libs libs-clean libs-cleanall

##RULE DECLARATION################################################
$(APP) : $(OBJSUBDIRS) $(ALLOBJ) 
##LINKING O FILES#################################################
	$(C) -o $(APP) $(patsubst $(SRC)%,$(OBJ)%,$(ALLOBJ) )  $(LINKFLAGS) $(LIBS)

##COMPILE ALL DETECTED C FILES####################################
$(foreach F,$(ALLS),$(eval $(call COMPILE,$(AS),$(call S2O,$(F)),$(F))))

##INFO DEFINITION#################################################
# Call "make info" on terminal to obtain values for the listed macros
info:
	$(info $(SUBDIRS))
	$(info $(OBJSUBDIRS))
	$(info $(ALLS))
	$(info $(ALLOBJ))

$(OBJSUBDIRS) :
	$(MKDIR) $(OBJSUBDIRS)
##DELETE OBJ FOLDER###############################################
# Call "make clean" to delete obj folder and all of its contents
clean:
	$(RM) -r "./$(OBJ)"
cleanall: clean
	$(RM) "./$(APP)"
##LIB RULES#######################################################
libs:
	$(MAKE) -C $(LIBDIR)
libs-clean:
	$(MAKE) -C $(LIBDIR) clean
libs-cleanall:
	$(MAKE) -C $(LIBDIR) cleanall