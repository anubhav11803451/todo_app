class QuoteModel {
  final String quoteText;
  final String quoteDate;
  final String quoteAuthor;

  QuoteModel({this.quoteText, this.quoteDate, this.quoteAuthor});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      quoteDate: json['qotd_date'],
      quoteText: json['quote']['body'],
      quoteAuthor: json['quote']['author'],
    );
  }
}

// class QuoteModel {
//   String qotdDate;
//   Quote quote;

//   QuoteModel({this.qotdDate, this.quote});

//   QuoteModel.fromJson(Map<String, dynamic> json) {
//     qotdDate = json['qotd_date'];
//     quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['qotd_date'] = this.qotdDate;
//     if (this.quote != null) {
//       data['quote'] = this.quote.toJson();
//     }
//     return data;
//   }
// }

// class Quote {
//   int id;
//   bool dialogue;
//   bool private;
//   List<String> tags;
//   String url;
//   int favoritesCount;
//   int upvotesCount;
//   int downvotesCount;
//   String author;
//   String authorPermalink;
//   String body;

//   Quote(
//       {this.id,
//       this.dialogue,
//       this.private,
//       this.tags,
//       this.url,
//       this.favoritesCount,
//       this.upvotesCount,
//       this.downvotesCount,
//       this.author,
//       this.authorPermalink,
//       this.body});

//   Quote.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     dialogue = json['dialogue'];
//     private = json['private'];
//     tags = json['tags'].cast<String>();
//     url = json['url'];
//     favoritesCount = json['favorites_count'];
//     upvotesCount = json['upvotes_count'];
//     downvotesCount = json['downvotes_count'];
//     author = json['author'];
//     authorPermalink = json['author_permalink'];
//     body = json['body'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['dialogue'] = this.dialogue;
//     data['private'] = this.private;
//     data['tags'] = this.tags;
//     data['url'] = this.url;
//     data['favorites_count'] = this.favoritesCount;
//     data['upvotes_count'] = this.upvotesCount;
//     data['downvotes_count'] = this.downvotesCount;
//     data['author'] = this.author;
//     data['author_permalink'] = this.authorPermalink;
//     data['body'] = this.body;
//     return data;
//   }
// }
