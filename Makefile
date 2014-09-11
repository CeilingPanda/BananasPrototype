program_NAME := BananasPrototype
program_C_SRCS := $(wildcard src/*.c)
program_CXX_SRCS := $(wildcard src/*.cpp)

program_C_OBJS := ${program_C_SRCS:.c=.o}
program_CXX_OBJS := $(program_CXX_SRCS:.cpp=.o)
program_OBJS := $(program_C_OBJS) $(program_CXX_OBJS)

program_INCLUDE_DIRS :=
program_LIBRARY_DIRS :=
program_LIBRARIES := sfml-graphics sfml-window sfml-audio sfml-system

CPPFLAGS += $(foreach includedir, $(program_INCLUDE_DIRS), -I$(includedir))
LDFLAGS += $(foreach librarydir, $(program_LIBRARY_DIRS), -L$(librarydir))
LDFLAGS += $(foreach library, $(program_LIBRARIES), -l$(library))

CFLAGS += -std=c11 -Wall -Wextra -pedantic
CXXFLAGS += -std=c++11 -Wall -Wextra -pedantic

DEBUG := NO
ifeq ($(DEBUG), YES)
CFLAGS += -g -Werror -pedantic-errors
CXXFLAGS += -g -Werror -pedantic-errors
program_NAME := $(program_NAME)_debug
endif

RELEASE := NO
ifeq ($(RELEASE), YES)
CFLAGS += -O2
CXXFLAGS += -O2
program_NAME := $(program_NAME)_release
endif

.PHONY: all run clean distclean
all: bin/$(program_NAME)
bin/$(program_NAME): $(program_OBJS)
	$(LINK.cc) $(program_OBJS) -o bin/$(program_NAME).o

run: all
	bin/$(program_NAME)
clean:
	@- $(RM) $(program_OBJS)
distclean: clean
	@- $(RM) bin/$(program_NAME)*
