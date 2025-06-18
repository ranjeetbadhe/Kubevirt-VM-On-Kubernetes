#!/bin/bash

echo "🔍 Checking PVCs..."
kubectl get pvc rocky-datavolume rocky-datavolume-scratch -o wide

echo -e "\n🔍 Checking PersistentVolumes..."
kubectl get pv | grep 'rocky'

echo -e "\n🔍 Checking DataVolume status..."
kubectl get dv rocky-datavolume -o custom-columns=NAME:.metadata.name,PHASE:.status.phase

echo -e "\n🔍 Checking importer pod status..."
kubectl get pods | grep importer

echo -e "\n🔍 Checking VM status..."
kubectl get vm rocky-vm -o custom-columns=NAME:.metadata.name,STATUS:.status.printableStatus

echo -e "\n🔍 Checking VMI (VirtualMachineInstance)..."
kubectl get vmi rocky-vm -o wide

echo -e "\n🔍 Events related to rocky-datavolume..."
kubectl get events --sort-by=.metadata.creationTimestamp | grep rocky

echo -e "\n📡 Testing console connection (virtctl)..."
if command -v virtctl &> /dev/null; then
  echo "Running: virtctl console rocky-vm (Press Ctrl+] to exit)"
  virtctl console rocky-vm
else
  echo "virtctl is not installed or not in PATH."
fi

