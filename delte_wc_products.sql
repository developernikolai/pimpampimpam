DELETE relations.*, taxes.*, terms.*
FROM wp_term_relationships AS relations
INNER JOIN wp_term_taxonomy AS taxes
ON relations.term_taxonomy_id=taxes.term_taxonomy_id
INNER JOIN wp_terms AS terms
ON taxes.term_id=terms.term_id
WHERE object_id IN (SELECT ID FROM wp_posts WHERE post_type IN ('product','product_variation'));
 
DELETE FROM wp_postmeta WHERE post_id IN (SELECT ID FROM wp_posts WHERE post_type IN ('product','product_variation'));
DELETE FROM wp_posts WHERE post_type  IN ('product','product_variation');

DELETE pm FROM wp_postmeta pm LEFT JOIN wp_posts wp ON wp.ID = pm.post_id WHERE wp.ID IS NULL;

delete from `wp_termmeta`
where 
	`term_id` in ( 
		SELECT `term_id`
		FROM `wp_term_taxonomy`
		WHERE `taxonomy` in ('product_cat', 'product_type', 'product_visibility') 
	);

delete from `wp_terms`  
where 
	`term_id` in ( 
		SELECT `term_id`
		FROM `wp_term_taxonomy`
		WHERE `taxonomy` in ('product_cat', 'product_type', 'product_visibility') 
	);
	
DELETE FROM `wp_term_taxonomy` WHERE `taxonomy` in ('product_cat', 'product_type', 'product_visibility');

DELETE meta FROM wp_termmeta meta LEFT JOIN wp_terms terms ON terms.term_id = meta.term_id WHERE terms.term_id IS NULL;

DELETE FROM wp_woocommerce_attribute_taxonomies;

DELETE a FROM wp_posts a LEFT JOIN wp_posts b ON a.post_parent=b.ID WHERE a.post_type='attachment' AND b.ID IS NULL;
