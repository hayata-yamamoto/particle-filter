default: | help

pf-py: ## python particle filter
	cd py && poetry run python tasks/particle_filter.py

pf-r: ## R particle filter
	cd R && Rscript partcileFilter.R

help:  ## Show all of tasks
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

