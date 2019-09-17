#!/usr/bin/env bash
molecule converge -s haya -- --extra-vars=@../../conf_with_logger_gelf.yml
