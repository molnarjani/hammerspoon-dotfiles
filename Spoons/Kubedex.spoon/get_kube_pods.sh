#!/bin/bash
/usr/local/bin/kubectl get pods | grep Running | grep -v '\-init'
