DIR_INC = ./include
DIR_SRC = ./src
DIR_OBJ = ./obj
DIR_BIN = ./bin

SRC = $(wildcard $(DIR_SRC)/*.cpp)
OBJ = $(patsubst %.cpp, $(DIR_OBJ)/%.o, $(notdir $(SRC)))

CXX = g++
CFLAGS = -std=c++14 -g -Wall -I$(DIR_INC) -pedantic -lpthread -lboost_system -lboost_filesystem
CXX_INCLUDE_DIRS = /usr/local/include
CXX_INCLUDE_PARAMS = $(addprefix -I, $(CXX_INCLUDE_DIRS))
CXX_LIB_DIRS = /usr/local/lib
CXX_LIB_PARAMS = $(addprefix -L, $(CXX_LIB_DIRS))

TARGET = socks_server

all:$(TARGET)

$(TARGET):$(OBJ)
	$(CXX) -o $@ $^

$(DIR_OBJ)/%.o: $(DIR_SRC)/%.cpp
	mkdir -p $(DIR_OBJ)
	$(CXX) $(CFLAGS) -c -o $@ $<


.PHONY:clean
clean:
	rm -rf $(DIR_OBJ)/*.o
