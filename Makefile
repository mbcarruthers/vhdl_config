VHDL_ENTITY = top
TOP_ENTITY = tb_top
# VHDL_SRC = src/top.vhdl 
SRC_DIR = src
TB_DIR  = tb
OUT_DIR = out
VHDL_ARGS = -fexplicit -fsynopsys --std=08 --workdir=$(OUT_DIR) 

ELABORATION := e~$(TOP_ENTITY).o # file created outside of out/ dir 
SRC_FILES := $(wildcard $(SRC_DIR)/*.vhdl)
# $(foreach ext,$(VHDL_EXTENSIONS),$(wildcard $(SRC_DIR)/*$(ext)))
# NOTE ^^^^ utilize that, test it 
TB_FILES  := $(wildcard $(TB_DIR)/*.vhdl)
VHDL_FILES := $(SRC_FILES) $(TB_FILES)

.PHONY: all lint elaborate wave vcd clean prepare help

.DEFAULT_GOAL := help

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nAvailable commands:\n"} \
	/^[a-zA-Z_-]+:.*##/ { printf "  %-15s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

all: wave ## Run simulation and open waveform

once: clean elaborate surf 

lint: prepare ## Syntax check only
	ghdl -s $(VHDL_ARGS) $(VHDL_FILES)

analyze: prepare ## Lint verbose 
	ghdl -a -v $(VHDL_ARGS) $(VHDL_FILES)

elaborate: analyze ## Compile and elaborate
	ghdl -e $(VHDL_ARGS) -o tb_top $(TOP_ENTITY)

ghw: ## creates ghw file
	ghdl -r $(VHDL_ARGS) $(TOP_ENTITY) --wave=$(OUT_DIR)/$(TOP_ENTITY).ghw

surf: elaborate ## Run and dump GHW waveform
	ghdl -r $(VHDL_ARGS) $(TOP_ENTITY) --wave=$(OUT_DIR)/$(TOP_ENTITY).ghw
	surfer $(OUT_DIR)/$(TOP_ENTITY).ghw &

vcd: elaborate ## Run and dump VCD waveform
	ghdl -r $(VHDL_ARGS) $(TOP_ENTITY) --vcd=$(OUT_DIR)/$(TOP_ENTITY).vcd
	surfer $(OUT_DIR)/$(TOP_ENTITY).vcd &

clean: ## Remove output directory
	@rm -rf $(OUT_DIR) $(TOP_ENTITY) $(ELABORATION)

prepare: ## Ensure output directory exists
	@mkdir -p $(OUT_DIR)

NEW_ENTITY ?= $(VHDL_ENTITY)
replace: ## alters the project into a new project
	find . -type f -exec sed -i 's/$(VHDL_ENTITY)/$(NEW_ENTITY)/g' {} + 
# In memorium 
# yosys -m ghdl -p "ghdl -fexplicit -fsynopsys --std=08 --workdir=. top; hierarchy -top top; proc; opt; write_json design.json "