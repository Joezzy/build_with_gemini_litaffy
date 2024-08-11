class GeneratedContent {
  String? type;
  String? text;

  GeneratedContent({this.type, this.text});

  GeneratedContent.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['text'] = text;
    return data;
  }
}

class Usage {
  int? inputTokens;
  int? outputTokens;

  Usage({this.inputTokens, this.outputTokens});

  Usage.fromJson(Map<String, dynamic> json) {
    inputTokens = json['input_tokens'];
    outputTokens = json['output_tokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['input_tokens'] = inputTokens;
    data['output_tokens'] = outputTokens;
    return data;
  }
}
