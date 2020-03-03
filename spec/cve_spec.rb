require_relative 'spec_helper'
require 'yaml'

describe 'CVE yml file' do

  cve_ymls.each do |file|

    context "#{File.basename(file)}" do
      it 'is legal YAML' do
        expect(YAML.load(File.open(file))).to be
      end

      let(:vuln) { YAML.load(File.open(file)) }

      it('has all the proper keys key')   { expect(vuln).to include('CVE') }
      it('has fixes key') { expect(vuln).to include('fixes') }
      it('has vccs key')  { expect(vuln).to include('vccs') }

      it 'has valid git hashes and commit/note structure in fixes, vccs, and interesting_commits' do
        vuln['fixes'].each do |fix|
          expect(fix['commit']).to(match(/[0-9a-f]{40,}/).or(be_nil))
        end
        vuln['vccs'].each do |fix|
          expect(fix['commit']).to(match(/[0-9a-f]{40,}/).or(be_nil))
        end
        vuln['interesting_commits']['commits'].each do |fix|
          expect(fix['commit']).to(match(/[0-9a-f]{40,}/).or(be_nil))
        end
      end

      context 'when curated, it must' do

        it 'have the CWE filled out' do
          if(vuln['curated'])
            expect(vuln['CWE'].to_s).not_to be_empty
          end
        end

        it 'have a description and mistakes made written' do
          if(vuln['curated'])
            expect(vuln['description'].to_s).not_to be_empty
            expect(vuln['mistakes']['answer'].to_s).not_to be_empty
          end
        end

        it 'have answers for unit_tested questions' do
          if(vuln['curated'] && vuln['i18n']!=nil)
            expect(vuln['unit_tested']['code']).to be(true).or(be(false))
            expect(vuln['unit_tested']['code_answer'].to_s).not_to be_empty
            expect(vuln['unit_tested']['fix']).to be(true).or(be(false))
            expect(vuln['unit_tested']['fix_answer'].to_s).not_to be_empty
          end
        end

        it 'have answers discovered and autodiscoverable' do
          if(vuln['curated'] && vuln['autodiscoverable']!=nil)
            expect(vuln['discovered']['answer'].to_s).not_to be_empty
            expect(vuln['discovered']['automated']).to be(true).or(be(false))
            expect(vuln['discovered']['contest']).to be(true).or(be(false))
            expect(vuln['discovered']['developer']).to be(true).or(be(false))
            expect(vuln['autodiscoverable']['answer_note'].to_s).not_to be_empty
            expect(vuln['autodiscoverable']['answer']).to be(true).or(be(false))
          end
        end

        it 'have answers for specification' do
          if(vuln['curated'] && vuln['i18n']!=nil)
            expect(vuln['specification']['answer_note'].to_s).not_to be_empty
            expect(vuln['specification']['answer']).to be(true).or(be(false))
          end
        end

        it 'have properly formatted subsystem names' do
          if(vuln['curated'] && vuln['i18n']!=nil)
            expect(vuln['subsystem']['answer'].to_s).not_to be_empty

            subsystem_str = Array[vuln['subsystem']['name']].join
            expect(subsystem_str).to match(/^[a-zA-Z\s0-9\_\-\@]+$/)
          end
        end

        it 'have answers for i18n' do
          if(vuln['curated'] && vuln['i18n']!=nil)
            expect(vuln['i18n']['note'].to_s).not_to be_empty
            expect(vuln['i18n']['answer']).to be(true).or(be(false))
          end
        end

        it 'have answers for ipc' do
          if(vuln['curated'] && vuln['ipc']!=nil)
            expect(vuln['ipc']['note'].to_s).not_to be_empty
            expect(vuln['ipc']['answer']).to be(true).or(be(false))
          end
        end

      end

      it 'has an empty nickname or under 30 chars' do
        expect(vuln['nickname'].to_s.length).to be <= 30
      end

      it 'has lessons properly formatted' do
        expect(vuln['lessons']['defense_in_depth']['applies']).to be(true).
                                                               or(be(false)).
                                                               or(be_nil)
        expect(vuln['lessons']['least_privilege']['applies']).to be(true).
                                                               or(be(false)).
                                                               or(be_nil)
        expect(vuln['lessons']['frameworks_are_optional']['applies']).to be(true).
                                                               or(be(false)).
                                                               or(be_nil)
        expect(vuln['lessons']['native_wrappers']['applies']).to be(true).
                                                               or(be(false)).
                                                               or(be_nil)
        expect(vuln['lessons']['distrust_input']['applies']).to be(true).
                                                               or(be(false)).
                                                               or(be_nil)
        expect(vuln['lessons']['security_by_obscurity']['applies']).to be(true).
                                                               or(be(false)).
                                                               or(be_nil)
        expect(vuln['lessons']['serial_killer']['applies']).to be(true).
                                                               or(be(false)).
                                                               or(be_nil)
        expect(vuln['lessons']['environment_variables']['applies']).to be(true).
                                                               or(be(false)).
                                                               or(be_nil)
        expect(vuln['lessons']['secure_by_default']['applies']).to be(true).
                                                               or(be(false)).
                                                               or(be_nil)
        expect(vuln['lessons']['yagni']['applies']).to be(true).
                                                               or(be(false)).
                                                               or(be_nil)
        expect(vuln['lessons']['complex_inputs']['applies']).to be(true).
                                                               or(be(false)).
                                                               or(be_nil)
      end

    end

  end

end
