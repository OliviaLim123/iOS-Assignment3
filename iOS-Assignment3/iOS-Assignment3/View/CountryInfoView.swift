//
//  CountryInfoView.swift
//  iOS-Assignment3
//
//  Created by Daniel
//

import SwiftUI
import MapKit

struct CountryInfoView: View {
    //  PROPERTIES
    @State private var selectedCountry: Country = emptyCountry;
    @ObservedObject private var countryAPI: CountryManager;
    @ObservedObject var viewModel: MapViewModel;
    
    //  INIT Function to get Country By Country Code
    init(countryCode: String, viewModel: MapViewModel){
        countryAPI = CountryManager();
        self.viewModel = viewModel;
        
        //  FETCH API BY CODE
        countryAPI.fetchCountryByCode(countryCode: countryCode);
    }
    
    //  INIT Function to get Country By Name
    init(countryName: String, viewModel: MapViewModel){
        countryAPI = CountryManager();
        self.viewModel = viewModel;
        
        //  FETCH API BY NAME
        countryAPI.fetchCountryByName(countryName: countryName);
    }
    
    var body: some View {
        VStack {
            //Text("COUNTRY INFO VIEW - DANIEL PART");
            
            //  WELCOME PART
            HStack {
                //  Country Name
                VStack(alignment: .leading) {
                    Text("Welcome to \(selectedCountry.name.common)!")
                        .foregroundStyle(.darkPurple)
                        .font(.custom("MontserratAlternates-SemiBold", size: 24))
                        .tracking(1)
                    
                    Text("\(selectedCountry.name.official)")
                        .foregroundStyle(.textColour)
                        .font(.custom("MontserratAlternates-SemiBold", size: 16))
                        .tracking(1)
                }
                
                Spacer();
                
                heartButton;
            }
            
            //  COUNTRY INFO
            countryInfo;
            
            Spacer()
            
            
        }
        .padding(.horizontal)
    }
    
    var heartButton: some View{
        //  BUTTON Image will be "heart.fill" if in FAV List
        //  BUTTON Image will be "heart" if not in FAV List
        Button{
            //  TOGGLE Favorite
            if(viewModel.isInFavList(countryCode: selectedCountry.cca3)){
                viewModel.userFavList.removeAll{
                    $0 == selectedCountry.cca3
                };
                
                //  SAVE FAV LIST TO APP STORAGE
                viewModel.saveFavList();
            }
            else{
                viewModel.userFavList.append(selectedCountry.cca3);
                
                //  SAVE FAV LIST TO APP STORAGE

                viewModel.saveFavList();
            }
        } label:{
            //  TOGGLE Heart Icon
            if(viewModel.isInFavList(countryCode: selectedCountry.cca3)){
                Image(systemName: "heart.fill")
                    .font(.custom("MontserratAlternates-SemiBold", size: 22))
                    .foregroundStyle(.red);
            }
            else{
                Image(systemName: "heart")
                    .font(.custom("MontserratAlternates-SemiBold", size: 22))
                    .foregroundStyle(.black);
            }
            
        }
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
                            .foregroundStyle(.royalPurple)
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
                            .fill(.yellowCustom)
                    );
                    
                    Spacer();
                    
                    //  MAP Part
                    VStack{
                        
                        mapView(country: self.selectedCountry);
                    }   //  Info Box VStack
                    .background(
                        //  INFO BOX BACKGROUND
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.yellowCustom)
                    );
                    
                    
                }
                .padding(.vertical, 5)
                
                //  SECOND LINE (REGION, SUB-REGION and Capital, Population)
                HStack(alignment: .top){
                    
                    VStack{
                        //  HStack To Stretch Info Box to fill empty space
                        HStack{
                            Spacer()
                        }
                        
                        //  REGION
                        VStack(alignment: .leading){
                            //  TITLES
                            Text("Region")
                                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                .foregroundStyle(.textColour)
                                .tracking(1)
                                .padding(.top, 10)
                                .padding(.bottom, 1);
                            
                            //  GET Country Region
                            VStack {
                                Text("\(selectedCountry.region)")
                                    .font(.system(size: 16))
                                    .tracking(0)
                                    .foregroundStyle(.textColour)
                            }
                            .fontDesign(.monospaced)
                            
                            //  SUB-REGION
                            VStack(alignment: .leading){
                                //  TITLES
                                Text("Sub-Region")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .foregroundStyle(.textColour)
                                    .tracking(1)
                                    .padding(.top, 5)
                                    .padding(.bottom, 1);
                                
                                //  GET Country Sub-Region
                                Text("\(selectedCountry.subregion)")
                                    .font(.system(size: 16))
                                    .tracking(0)
                                    .foregroundStyle(.textColour)
                            }
                            .padding(.bottom)
                            
                        }
                    }   //  SECOND BOX VStack
                    .padding(.horizontal)
                    .background(
                        //  INFO BOX BACKGROUND
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.lightPurple)
                    )
                    
                    Spacer();
                    
                    //  CAPITAL & POPULATION Box
                    VStack{
                        //  HStack To Stretch Info Box to fill empty space
                        HStack{
                            Spacer()
                        }
                        
                        //  CAPITAL
                        VStack(alignment: .leading){
                            //  TITLES
                            Text("Capital")
                                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                .foregroundStyle(.textColour)
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
                                                .foregroundStyle(.textColour)
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
                                    .foregroundStyle(.textColour)
                                    .tracking(1)
                                    .padding(.top, 5)
                                    .padding(.bottom, 1);
                                
                                Text("\(selectedCountry.population)")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.textColour)
                                    .tracking(0)
                            }
                            .padding(.bottom)
                            
                        }
                    }   //  SECOND BOX VStack
                    .padding(.horizontal)
                    .background(
                        //  INFO BOX BACKGROUND
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.lightPurple)
                    )
                    
                }   //  SECOND LINE HStack
                .padding(.vertical, 5)
                
                //  THIRD LINE (MORE INFO)
                VStack{
                    //  TITLE
                    VStack {
                        Text("More Info")
                            .font(.custom("MontserratAlternates-SemiBold", size: 20))
                            .foregroundStyle(.royalPurple)
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
                                .foregroundStyle(.textColour)
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
                                                .foregroundStyle(.textColour)
                                                .tracking(0);
                                            
                                            Spacer()
                                            
                                            Text("(\(currency.value.symbol))")
                                                .font(.system(size: 20))
                                                .foregroundStyle(.textColour)
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
                                .fill(.lightPurple)
                        )
                        
                        Spacer();
                        
                        //  BORDER and Language
                        HStack{
                            //  BORDER
                            VStack(alignment: .leading){
                                Text("Borders")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .foregroundStyle(.textColour)
                                    .tracking(1)
                                    .padding(.top, 10)
                                    .padding(.bottom, 1);
                                
                                //  GET Country's Border Neighbors
                                ScrollView {
                                    ForEach(selectedCountry.borders, id: \.self){ neighborCountry in
                                        HStack{
                                            Text("\(neighborCountry)")
                                                .foregroundStyle(.textColour)
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
                                    .fill(.lightPurple)
                            )
                            
                            Spacer()
                            
                            //  LANGUAGE
                            VStack(alignment: .leading){
                                Text("Language")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .foregroundStyle(.textColour)
                                    .tracking(1)
                                    .padding(.top, 10)
                                    .padding(.bottom, 1);
                                
                                //  GET Country's Border Neighbors
                                ScrollView {
                                    //  GET Country Languages
                                    ForEach(selectedCountry.languages.sorted(by: { $0.key < $1.key }), id: \.key) { lang in
                                        HStack{
                                            Text("\(lang.value)")
                                                .foregroundStyle(.textColour)
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
                                    .fill(.lightPurple)
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
                        .fill(.yellowCustom)
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
    
    //  MAP VIEW
    func mapView(country: Country) -> some View{
        @State var region = MKCoordinateRegion (center: CLLocationCoordinate2D (latitude: country.latlng[0], longitude: country.latlng[1]), span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20));
        
        return Map(coordinateRegion: $region, annotationItems: [country]) { country in
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: country.latlng[0], longitude: country.latlng[1]), tint: .mint)
        }
        .mapStyle(.standard(elevation: .realistic))
        .padding(10)
    }
    
}

#Preview {
    CountryInfoView(countryCode: "vnm", viewModel: MapViewModel())
}
