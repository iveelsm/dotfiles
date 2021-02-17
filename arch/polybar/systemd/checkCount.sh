#!/usr/bin/env bash

echo $(systemctl --type=service --state=running list-units --no-pager | grep running | wc -l)