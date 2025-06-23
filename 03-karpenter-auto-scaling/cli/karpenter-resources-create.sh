#!/bin/bash

function enableKubernetesClusterConnection(){
    aws eks update-kubeconfig --region $REGION --name $CLUSTER_NAME
}

function replaceKarpenterPlaceholders(){
   sed -i "s|\${CLUSTER_NAME}|$CLUSTER_NAME|g" ./resources/karpenter-node-class.yml
   sed -i "s|\${KARPENTER_NODE_ROLE}|$KARPENTER_NODE_ROLE|g" ./resources/karpenter-node-class.yml
}

function CreateKarpenterResources(){
    kubectl apply -f ./resources/karpenter-node-class.yml
    kubectl apply -f ./resources/karpenter-node-pool.yml
}

enableKubernetesClusterConnection
replaceKarpenterPlaceholders
CreateKarpenterResources