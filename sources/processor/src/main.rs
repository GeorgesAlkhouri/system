use rust_bert::bert::{
	BertConfigResources, BertModelResources, BertVocabResources,
};
use rust_bert::pipelines::common::{ModelResource, ModelType};
use rust_bert::pipelines::ner::NERModel;
use rust_bert::pipelines::token_classification::{
	LabelAggregationOption, TokenClassificationConfig,
};
use rust_bert::resources::RemoteResource;

fn main() -> anyhow::Result<()> {
	//    Load a configuration
	let config = TokenClassificationConfig::new(
		ModelType::Bert,
		ModelResource::Torch(Box::new(RemoteResource::from_pretrained(
			BertModelResources::BERT_NER,
		))),
		RemoteResource::from_pretrained(BertConfigResources::BERT_NER),
		RemoteResource::from_pretrained(BertVocabResources::BERT_NER),
		None,  //merges resource only relevant with ModelType::Roberta
		false, //lowercase
		false,
		None,
		LabelAggregationOption::Mode,
	);

	//    Create the model
	let token_classification_model = NERModel::new(config)?;
	let input = [
		"My name is Amélie. I live in Москва.",
		"Chongqing is a city in China.",
	];
	let token_outputs = token_classification_model.predict(&input);

	for token in token_outputs {
		println!("{token:?}");
	}

	Ok(())
}
