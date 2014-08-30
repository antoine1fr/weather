SOURCE_DIR = src/
BUILD_DIR = _build/

TARGET_BASE = weather
TARGET_BYTE = $(TARGET_BASE).byte
TARGET_NATIVE = $(TARGET_BASE).native

SOURCE_FILES = \
	$(SOURCE_DIR)response_j.ml \
	$(SOURCE_DIR)response_t.ml \
	$(SOURCE_DIR)art.ml \
	$(SOURCE_DIR)weather.ml

ATDGEN = atdgen
BUILD = corebuild
RM = rm -rf
PACKAGES = -pkgs uri,cohttp.async,atdgen

$(TARGET_NATIVE): $(SOURCE_FILES)
	$(BUILD) $(PACKAGES) $(SOURCE_DIR)$(TARGET_NATIVE)

$(TARGET_BYTE): $(SOURCE_FILES)
	$(BUILD) $(PACKAGES) $(SOURCE_DIR)$(TARGET_BYTE)

all.native: $(TARGET_NATIVE)

all.byte: $(TARGET_BYTE)

all: all.native all.byte

clean:
	$(RM) $(BUILD_DIR) $(TARGET_NATIVE) $(TARGET_BYTE) \
		$(SOURCE_DIR)response_j.ml $(SOURCE_DIR)response_j.mli \
		$(SOURCE_DIR)response_t.ml $(SOURCE_DIR)response_t.mli

.PHONY: all.native all.byte all clean

$(SOURCE_DIR)response_j.ml: $(SOURCE_DIR)response.atd
	$(ATDGEN) -j $(SOURCE_DIR)response.atd

$(SOURCE_DIR)response_t.ml: $(SOURCE_DIR)response.atd
	$(ATDGEN) -t $(SOURCE_DIR)response.atd