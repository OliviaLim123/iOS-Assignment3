//
//  CountryInfoView.swift
//  iOS-Assignment3
//
//  Created by Daniel
//

import SwiftUI

struct CountryInfoView: View {
    //  PROPERTIES
    @State private var selectedCountry: Country = emptyCountry;
    @State private var countryName: String = "Vietnam"
    @ObservedObject private var countryAPI: CountryManager;
    
    init(){
        countryAPI = CountryManager();
        
        //  FETCH API BY NAME
        countryAPI.fetchCountryByName(countryName: self.countryName);
    }
    
    var body: some View {
        VStack {
            Text("COUNTRY INFO VIEW - DANIEL PART");
            
            //  WELCOME PART
            HStack {
                Text("Welcome to \(selectedCountry.name.common)!")
                    .font(.custom("MontserratAlternates-SemiBold", size: 24))
                    .tracking(1)
                
                Spacer()
                
                Image(systemName: "heart")
                    .font(.custom("MontserratAlternates-SemiBold", size: 24))
            }
            
            //  COUNTRY INFO
            countryInfo;
            
            Spacer()
            
            
        }
        .padding(.horizontal)
    }
    
    var countryInfo: some View{
        VStack{
            //  FIRST LINE (FLAG and MAP)
            HStack{
                //  FLAG Part
                VStack(alignment: .leading){
                    Text("The Flag")
                        .font(.custom("MontserratAlternates-SemiBold", size: 18))
                        .tracking(0)
                        .padding(.horizontal)
                        .padding(.top, 10);
                    
                    //  FLAG IMG
                    AsyncImage(url: URL(string: selectedCountry.flags.png)){ image in
                        image.resizable();
                    } placeholder: {
                        Color.gray;
                    }
                    .padding([.bottom, .horizontal])
                    .frame(width: 170, height: 110)
                }
                .background(
                    //  INFO BOX BACKGROUND
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.sweetCorn.opacity(0.6))
                );
                
                Spacer();
                
                //  MAP
            }
            
        }   //  OUTERMOST VStack
        .onReceive(countryAPI.$countriesList){countryData in
            if let safeCountry = countryData{
                selectedCountry = safeCountry[0]
            }
        }
    }
}

#Preview {
    CountryInfoView()
}
