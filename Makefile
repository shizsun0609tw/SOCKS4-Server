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
TARGET2 = console

all:$(TARGET) $(TARGET2)

$(TARGET):$(filter-out $(DIR_OBJ)/$(TARGET2).o, $(OBJ))
	$(CXX) -o $@ $^ $(CFLAGS) $(CXX_INCLUDE_PARAMS) $(CXX_LIB_PARAMS)

$(TARGET2):$(DIR_OBJ)/$(TARGET2).o
	$(CXX) -o hw4.cgi $< $(CFLAGS) $(CXX_INCLUDE_PARAMS) $(CXX_LIB_PARAMS)

$(DIR_OBJ)/%.o: $(DIR_SRC)/%.cpp
	mkdir -p $(DIR_OBJ)
	$(CXX) -c -o $@ $< $(CFLAGS) $(CXX_INCLUDE_PARAMS) $(CXX_LIB_PARAMS)


.PHONY:clean
clean:
	rm -rf $(DIR_OBJ)/*.o
	rm -f $(TARGET)
	rm -f $(TARGET2)
