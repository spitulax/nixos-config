PREFIX ?= $(HOME)/.local
BIN_DIR ?= $(PREFIX)/bin

TARGET_EXEC ?= foobar
BUILD_DIR ?= ./build
SRC_DIR	?= ./src

SRCS := $(shell find $(SRC_DIR) -name *.cpp -or -name *.c)
OBJS := $(SRCS:$(SRC_DIR)/%=$(BUILD_DIR)/%.o)

# Common flags
CPPFLAGS += -Wall -Wextra -ggdb

# C specific flags
CFLAGS +=

# C++ specific flags
CXXFLAGS +=

# Linker flags
LDFLAGS +=

# Executable
$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# C source
$(BUILD_DIR)/%.c.o: $(SRC_DIR)/%.c
	mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# C++ source
$(BUILD_DIR)/%.cpp.o: $(SRC_DIR)/%.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

.PHONY: all run install clean

all: $(BUILD_DIR)/$(TARGET_EXEC)

run: $(BUILD_DIR)/$(TARGET_EXEC)
	./$<

install: $(BUILD_DIR)/$(TARGET_EXEC)
	install -Dt $(BIN_DIR) $<

clean:
	rm -r $(BUILD_DIR)
