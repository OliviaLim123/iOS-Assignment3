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
    @ObservedObject private var countryAPI: CountryManager;
    
    //  INIT Function to get Country By Country Code
    init(countryCode: String){
        countryAPI = CountryManager();
        
        //  FETCH API BY CODE
        countryAPI.fetchCountryByCode(countryCode: countryCode);
    }
    
    //  INIT Function to get Country By Name
    init(countryName: String){
        countryAPI = CountryManager();
        
        //  FETCH API BY NAME
        countryAPI.fetchCountryByName(countryName: countryName);
    }
    
    var body: some View {
        VStack {
            Text("COUNTRY INFO VIEW - DANIEL PART");
            
            //  WELCOME PART
            HStack {
                Text("Welcome to \(selectedCountry.name.common)!")
                    .foregroundStyle(.darkPurple)
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
        ScrollView {
            VStack{
                //  FIRST LINE (FLAG and MAP)
                HStack{
                    //  FLAG Part
                    VStack(alignment: .leading){
                        Text("The Flag")
                            .font(.custom("MontserratAlternates-SemiBold", size: 20))
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
                        .frame(width: 170, height: 100)
                    }
                    .background(
                        //  INFO BOX BACKGROUND
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.sweetCorn.opacity(0.5))
                    );
                    
                    Spacer();
                    
                    //  MAP Part
                    
                    
                }
                .padding(.vertical, 5)
                
                //  SECOND LINE (REGION and SUB-REGION)
                HStack(alignment: .top){
                    
                    VStack{
                        //  REGION
                        VStack(alignment: .leading){
                            //  TITLES
                            Text("Region")
                                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                .tracking(1)
                                .padding(.top, 10)
                                .padding(.bottom, 1);
                            
                            //  GET Country Region
                            VStack {
                                Text("\(selectedCountry.region)")
                                    .font(.system(size: 16))
                                    .tracking(0)
                            }
                            .fontDesign(.monospaced)
                            
                            //  SUB-REGION
                            VStack(alignment: .leading){
                                //  TITLES
                                Text("Sub-Region")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .tracking(1)
                                    .padding(.top, 5)
                                    .padding(.bottom, 1);
                                
                                //  GET Country Sub-Region
                                Text("\(selectedCountry.subregion)")
                                    .font(.system(size: 16))
                                    .tracking(0)
                            }
                            .padding(.bottom, 10)
                            
                        }
                    }   //  SECOND BOX VStack
                    .padding(.horizontal)
                    .background(
                        //  INFO BOX BACKGROUND
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.mauve.opacity(0.5))
                    )
                    
                    Spacer();
                    
                    //  CAPITAL & POPULATION Box
                    VStack{
                        //  CAPITAL
                        VStack(alignment: .leading){
                            //  TITLES
                            Text("Capital")
                                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                .tracking(1)
                                .padding(.top, 10)
                                .padding(.bottom, 1);
                            
                            //  GET Country Capitals
                            VStack {
                                VStack(alignment: .leading) {
                                    ForEach(selectedCountry.capital, id: \.self) { cap in
                                        HStack {
                                            Text("\(cap)")
                                                .font(.system(size: 16))
                                                .tracking(0)
                                                                                    
                                        };
                                    }
                                }
                            }
                            .fontDesign(.monospaced)
                            
                            //  POPULATION
                            VStack(alignment: .leading){
                                //  TITLES
                                Text("Population")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .tracking(1)
                                    .padding(.top, 5)
                                    .padding(.bottom, 1);
                                
                                Text("\(selectedCountry.population)")
                                    .font(.system(size: 16))
                                    .tracking(0)
                            }
                            .padding(.bottom, 10)
                            
                        }
                    }   //  SECOND BOX VStack
                    .padding(.horizontal)
                    .background(
                        //  INFO BOX BACKGROUND
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.mauve.opacity(0.5))
                    )
                    
                }   //  SECOND LINE HStack
                .padding(.vertical, 5)
                
                //  THIRD LINE (MORE INFO)
                VStack{
                    //  TITLE
                    VStack {
                        Text("More Info")
                            .font(.custom("MontserratAlternates-SemiBold", size: 20))
                            .tracking(1)
                            .padding(.top, 10)
                            .padding(.bottom, 1);
                    }
                    .padding(.horizontal);
                    
                    //  INFO AREA
                    VStack{
                        //  CURRENCY Box
                        VStack(alignment: .leading){
                            Text("Currency")
                                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                .tracking(1)
                                .padding(.top, 10)
                                .padding(.bottom, 1);
                            
                            //  GET Country Currency
                            VStack {
                                ForEach(selectedCountry.currencies.sorted(by: { $0.key < $1.key }), id: \.key) { currency in
                                    VStack(alignment: .leading) {
                                        
                                        HStack{
                                            Text("\(currency.value.name)")
                                                .font(.system(size: 16))
                                                .tracking(0);
                                            
                                            Spacer()
                                            
                                            Text("(\(currency.value.symbol))")
                                                .font(.system(size: 20))
                                                .tracking(0)
                                        }
                                    }
                                    .padding(.bottom, 5)
                                }
                                
                            }
                            .fontDesign(.monospaced)
                            .padding(.bottom, 5);
                            
                        }   //  FIRST BOX VStack
                        .padding(.horizontal)
                        .background(
                            //  INFO BOX BACKGROUND
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.mauve.opacity(0.5))
                        )
                        
                        Spacer();
                        
                        //  BORDER and Language
                        HStack{
                            //  BORDER
                            VStack(alignment: .leading){
                                Text("Borders")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .tracking(1)
                                    .padding(.top, 10)
                                    .padding(.bottom, 1);
                                
                                //  GET Country's Border Neighbors
                                ScrollView {
                                    ForEach(selectedCountry.borders, id: \.self){ neighborCountry in
                                        HStack{
                                            Text("\(neighborCountry)")
                                                .padding(.bottom, 5);
                                            
                                            Spacer();
                                        }
                                    }
                                }
                                .font(.system(size: 16))
                                .tracking(0)
                                .frame(maxWidth: 120, maxHeight: 200)
                                .padding(.bottom, 5);
                                
                            }
                            .fontDesign(.monospaced)
                            .padding(.horizontal)
                            .background(
                                //  INFO BOX BACKGROUND
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.mauve.opacity(0.5))
                            )
                            
                            Spacer()
                            
                            //  LANGUAGE
                            VStack(alignment: .leading){
                                Text("Language")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .tracking(1)
                                    .padding(.top, 10)
                                    .padding(.bottom, 1);
                                
                                //  GET Country's Border Neighbors
                                ScrollView {
                                    //  GET Country Languages
                                    ForEach(selectedCountry.languages.sorted(by: { $0.key < $1.key }), id: \.key) { lang in
                                        HStack{
                                            Text("\(lang.value)")
                                                .padding(.bottom, 5);
                                            
                                            Spacer();
                                        }
                                    }
                                }
                                .font(.system(size: 16))
                                .tracking(0)
                                .frame(maxHeight: 200)
                                .padding(.bottom, 5);
                                
                            }
                            .fontDesign(.monospaced)
                            .padding(.horizontal)
                            .background(
                                //  INFO BOX BACKGROUND
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.mauve.opacity(0.5))
                            )
                        }
                    }
                    .padding(.horizontal);
                    
                    Spacer();
                }   //  THIRD LINE VStack
                .padding(.bottom, 10)
                .background(
                    //  INFO BOX BACKGROUND
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.sweetCorn.opacity(0.4))
                )
                
                Spacer();
            }   //  OUTERMOST VStack
            .onReceive(countryAPI.$country){countryData in
                if let safeCountry = countryData{
                    selectedCountry = safeCountry;
                }
            }
        };
    }
}

#Preview {
    CountryInfoView(countryCode: "ZWE")
}
