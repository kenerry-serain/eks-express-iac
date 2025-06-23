#!/bin/bash

function enableKubernetesClusterConnection(){
    aws eks update-kubeconfig --region $REGION --name $CLUSTER_NAME
}

function installKarpenterCustomResourceDefinitions(){
    kubectl create -f \
        "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v1.5.0/pkg/apis/crds/karpenter.sh_nodepools.yaml"
    
    kubectl create -f \
        "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v1.5.0/pkg/apis/crds/karpenter.k8s.aws_ec2nodeclasses.yaml"
    
    kubectl create -f \
        "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v1.5.0/pkg/apis/crds/karpenter.sh_nodeclaims.yaml"
}

enableKubernetesClusterConnection
installKarpenterCustomResourceDefinitions