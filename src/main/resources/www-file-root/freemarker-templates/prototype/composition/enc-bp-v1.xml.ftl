<composition xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:type="COMPOSITION" xmlns="http://schemas.openehr.org/v1"
	archetype_node_id="openEHR-EHR-COMPOSITION.encounter.v1">
	<name>
		<value>Besöksanteckning</value>
	</name>
	<archetype_details>
		<archetype_id>
			<value>openEHR-EHR-COMPOSITION.encounter.v1</value>
		</archetype_id>
		<rm_version>1.0.1</rm_version>
	</archetype_details>
	<language>
		<terminology_id>
			<value>ISO_639-1</value>
		</terminology_id>
		<code_string>sv</code_string>
	</language>
	<territory>
		<terminology_id>
			<value>ISO_3166-1</value>
		</terminology_id>
		<code_string>SE</code_string>
	</territory>
	<category>
		<value>event</value>
		<defining_code>
			<terminology_id>
				<value>openehr</value>
			</terminology_id>
			<code_string>433</code_string>
		</defining_code>
	</category>
	<composer xsi:type="PARTY_IDENTIFIED">
		<name>d.sk. Emma Skog</name>
	</composer>
	<context>
		<start_time>
			<value>2007-11-07T14:20:00</value>
		</start_time>
		<setting>
			<value>vårdcentral</value>
			<defining_code>
				<terminology_id>
					<value>openehr</value>
				</terminology_id>
				<code_string>228</code_string>
			</defining_code>
		</setting>
		<!--
			<other_context xsi:type="ITEM_TREE" archetype_node_id="at0001">
			<name> <value>Tree</value> </name> <items xsi:type="ELEMENT"
			archetype_node_id="at0002"> <name> <value>Episode identifier</value>
			</name> <value xsi:type="DV_TEXT">
			<value>2c4a06c2-e3bd-4cd3-a6bb-1fd83df66107</value> </value> </items>
			</other_context>
		-->
		<health_care_facility>
			<name>VC Lyckan</name>
		</health_care_facility>
	</context>
	<content xsi:type="OBSERVATION" archetype_node_id="openEHR-EHR-OBSERVATION.blood_pressure.v1">
		<name>
			<value>Blodtryck</value>
		</name>
		<archetype_details>
			<archetype_id>
				<value>openEHR-EHR-OBSERVATION.blood_pressure.v1</value>
			</archetype_id>
			<rm_version>1.0.1</rm_version>
		</archetype_details>
		<language>
			<terminology_id>
				<value>ISO_639-1</value>
			</terminology_id>
			<code_string>sv</code_string>
		</language>
		<encoding>
			<terminology_id>
				<value>IANA_character-sets</value>
			</terminology_id>
			<code_string>UTF-8</code_string>
		</encoding>
		<subject xsi:type="PARTY_SELF" />
		<protocol xsi:type="ITEM_LIST" archetype_node_id="at0011">
			<name>
				<value>protocol</value>
			</name>
			<items archetype_node_id="at0014">
				<name>
					<value>Mätställe</value>
				</name>
				<value xsi:type="DV_CODED_TEXT">
					<value>Höger arm</value>
					<defining_code>
						<terminology_id>
							<value>local</value>
						</terminology_id>
						<code_string>at0025</code_string>
					</defining_code>
				</value>
			</items>
		</protocol>
		<data archetype_node_id="at0001">
			<name>
				<value>data</value>
			</name>
			<origin>
				<value>2007-11-07T14:29:00</value>
			</origin>
			<events xsi:type="POINT_EVENT" archetype_node_id="at0006">
				<name>
					<value>any event</value>
				</name>
				<time>
					<value>2007-11-07T14:29:00</value>
				</time>
				<data xsi:type="ITEM_LIST" archetype_node_id="at0003">
					<name>
						<value>data</value>
					</name>
					<items archetype_node_id="at0004">
						<name>
							<value>systolic</value>
						</name>
						<value xsi:type="DV_QUANTITY">
							<magnitude>190</magnitude>
							<units>mm[Hg]</units>
						</value>
					</items>
					<items archetype_node_id="at0005">
						<name>
							<value>diastolic</value>
						</name>
						<value xsi:type="DV_QUANTITY">
							<magnitude>105</magnitude>
							<units>mm[Hg]</units>
						</value>
					</items>
				</data>
			</events>
		</data>
	</content>
</composition>
