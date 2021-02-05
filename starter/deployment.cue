package starter

import (
    "github.com/delyvr/cue/k8s:apps"
)

#Deployment: apps.v1.#Deployment
#Deployment: {
    #name: string
    #image: string
    #replicas: int | *1
    #port: int | *80
    
    #namespace?: string
    #labels: {[string]: string} | null
    

    metadata: {
        name: #name
        namespace: #namespace
        labels: #labels
    }
    spec: {
        replicas: #replicas
        selector: {
            matchLabels: {
                "app": #name
            }
        }
        template: {
            metadata: {
                labels: {
                    #labels
                    "app": #name
                }
            }
            spec: {
                containers: [
                    {
                        name: "app"
                        image: #image
                        ports: [
                            {
                                containerPort: #port
                            }
                        ]
                    }
                ]
            }
        }
    }
}
