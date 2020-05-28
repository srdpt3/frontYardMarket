//
//  MapView.swift
//  DistanceEval
//
//  Created by Dustin yang on 5/9/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI
import MapKit



struct MapView: UIViewRepresentable {
    
    @Binding var ceterCoordinate : CLLocationCoordinate2D
    var mapAnnotations: [MKPointAnnotation]
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setCenter(CLLocationCoordinate2DMake(40.758896, -73.985130), animated: true)
        return mapView
    }
    
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if mapAnnotations.count !=  uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations )
            uiView.addAnnotations(mapAnnotations)
        }
    }
    
     func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator : NSObject, MKMapViewDelegate{
        var mapViewParent : MapView
        init(_ parent: MapView){
            self.mapViewParent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            mapViewParent.ceterCoordinate = mapView.centerCoordinate
        }
    }
    
    
    
}

extension MKPointAnnotation{
    static var example : MKPointAnnotation{
        let annotation = MKPointAnnotation();
        annotation.title = "Time Square"
        annotation.coordinate = CLLocationCoordinate2DMake(40.758896, -73.985130)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider
{
    static var previews: some View {
        MapView(ceterCoordinate: .constant(MKPointAnnotation.example.coordinate), mapAnnotations: [MKPointAnnotation.example])
    }
}



