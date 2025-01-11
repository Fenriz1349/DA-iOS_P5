//
//  Double+Ext.swift
//  Aura
//
//  Created by Julien Cotte on 29/11/2024.
//

import Foundation

extension Double {
    // Methode pour convertir un Double en nombre à 2 virgules, changer le point en virgule et ajouter le symbole euro derrière
    func toEuroFormat() -> String {
        return String(format: "%.2f€", self).replacingOccurrences(of: ".", with: ",")
    }
}
