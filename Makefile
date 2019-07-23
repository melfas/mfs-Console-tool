###############################################
# Makefile for melfas firmware update program
#
# jsj1012@melfas.com
# melfas
# 2019-06-12
###############################################

all: melfas_update_tool

CC       ?= gcc
CFLAGS   ?= -g

CXX      ?= g++ 
CXXFLAGS ?= -g
	
COBJS     = lib/hid.o
CPPOBJS   = src/main.o
CPPOBJS   += src/mfsConfig.o
OBJS      = $(COBJS) $(CPPOBJS)
LDFLAGS   = $(shell pkg-config libusb-1.0 --libs)
LDFLAGS   += $(shell pkg-config libudev --libs)
LIBS      = -lpthread
INCLUDES = -I include/ -I/usr/include/
INCLUDES += $(shell pkg-config libusb-1.0 --cflags)

@echo $(INCLUDES)
@echo $(LDFLAGS)

melfas_update_tool: $(OBJS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $^ $(LIBS) -o melfas_update_tool

$(COBJS): %.o: %.c
	$(CC) $(CFLAGS) -c $(INCLUDES) $< -o $@

$(CPPOBJS): %.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $(INCLUDES) $< -o $@

clean:
	rm -f $(OBJS) melfas_update_tool

.PHONY: clean
