class Feature {
    Feature({
        this.title,
        this.description,
        this.image,
    });

    String? title;
    String? description;
    String? image;

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        title: json["title"],
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "image": image,
    };

    

}