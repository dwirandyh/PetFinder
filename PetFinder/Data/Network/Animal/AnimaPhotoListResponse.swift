//
//  AnimalPictureListResponse.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import Foundation

struct AnimalPhotoListResponse: Codable {
    let page, perPage: Int
    let photos: [Photo]
    let totalResults: Int
    let nextPage: String

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
        case totalResults = "total_results"
        case nextPage = "next_page"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page) ?? 0
        self.perPage = try container.decodeIfPresent(Int.self, forKey: .perPage) ?? 0
        self.photos = try container.decodeIfPresent([AnimalPhotoListResponse.Photo].self, forKey: .photos) ?? []
        self.totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
        self.nextPage = try container.decodeIfPresent(String.self, forKey: .nextPage) ?? ""
    }
}

extension AnimalPhotoListResponse {
    // MARK: - Photo
    struct Photo: Codable {
        let id, width, height: Int
        let url: String
        let photographer: String
        let photographerURL: String
        let photographerID: Int
        let avgColor: String
        let src: Src
        let liked: Bool
        let alt: String
        
        enum CodingKeys: String, CodingKey {
            case id, width, height, url, photographer
            case photographerURL = "photographer_url"
            case photographerID = "photographer_id"
            case avgColor = "avg_color"
            case src, liked, alt
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<AnimalPhotoListResponse.Photo.CodingKeys> = try decoder.container(keyedBy: AnimalPhotoListResponse.Photo.CodingKeys.self)
            self.id = try container.decodeIfPresent(Int.self, forKey: AnimalPhotoListResponse.Photo.CodingKeys.id) ?? 0
            self.width = try container.decodeIfPresent(Int.self, forKey: AnimalPhotoListResponse.Photo.CodingKeys.width) ?? 0
            self.height = try container.decodeIfPresent(Int.self, forKey: AnimalPhotoListResponse.Photo.CodingKeys.height) ?? 0
            self.url = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Photo.CodingKeys.url) ?? ""
            self.photographer = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Photo.CodingKeys.photographer) ?? ""
            self.photographerURL = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Photo.CodingKeys.photographerURL) ?? ""
            self.photographerID = try container.decodeIfPresent(Int.self, forKey: AnimalPhotoListResponse.Photo.CodingKeys.photographerID) ?? 0
            self.avgColor = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Photo.CodingKeys.avgColor) ?? ""
            self.src = try container.decode(AnimalPhotoListResponse.Src.self, forKey: AnimalPhotoListResponse.Photo.CodingKeys.src)
            self.liked = try container.decodeIfPresent(Bool.self, forKey: AnimalPhotoListResponse.Photo.CodingKeys.liked) ?? false
            self.alt = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Photo.CodingKeys.alt) ?? ""
        }
    }
    
    // MARK: - Src
    struct Src: Codable {
        let original, large2X, large, medium: String
        let small, portrait, landscape, tiny: String
        
        enum CodingKeys: String, CodingKey {
            case original
            case large2X = "large2x"
            case large, medium, small, portrait, landscape, tiny
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<AnimalPhotoListResponse.Src.CodingKeys> = try decoder.container(keyedBy: AnimalPhotoListResponse.Src.CodingKeys.self)
            self.original = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Src.CodingKeys.original) ?? ""
            self.large2X = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Src.CodingKeys.large2X) ?? ""
            self.large = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Src.CodingKeys.large) ?? ""
            self.medium = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Src.CodingKeys.medium) ?? ""
            self.small = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Src.CodingKeys.small) ?? ""
            self.portrait = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Src.CodingKeys.portrait) ?? ""
            self.landscape = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Src.CodingKeys.landscape) ?? ""
            self.tiny = try container.decodeIfPresent(String.self, forKey: AnimalPhotoListResponse.Src.CodingKeys.tiny) ?? ""
        }
    }
}

extension AnimalPhotoListResponse.Photo {
    func toEntity() -> AnimalPhoto {
        return AnimalPhoto(
            id: id,
            photographer: photographer,
            photographerURL: URL(string: photographerURL),
            photo: src.toEntity()
        )
    }
}

extension AnimalPhotoListResponse.Src {
    func toEntity() -> AnimalPhoto.PhotoSource {
        return AnimalPhoto.PhotoSource(
            original: original,
            large: large,
            medium: medium,
            small: small,
            portrait: portrait,
            landspace: landscape,
            tiny: tiny
        )
    }
}
